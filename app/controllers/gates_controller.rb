class GatesController < ApplicationController
  before_action :authenticate_user! ,only: [:edit, :destory , :new, :create, :manage]
  before_action :find_gate_id, except: [:index, :show, :new, :create, :search_tag, :manage, :join_server ]

  # 將 Gate Model 資料傳進實體變數 @gates
  def index
    @gates = Gate.public_server.includes(:user, :like_logs, :taggings, :tags)
    @gates = @gates.left_joins(:like_logs).group(:id).order('COUNT(like_logs.id)DESC').page(params[:page]).per(9)
    @tags = ActsAsTaggableOn::Tag.most_used(20)
  end

  def show  
    @gate = Gate.public_server.find(params[:id])     
  end

  # 在 Controller 設定實體變數 @gate 給 view 的 form_for 使用
  def new
    @gate = Gate.new
  end

  # 將已過濾的資料存進實體變數 @gate 當中
  def create
    @gate = Gate.new(gate_params)
    @gate.user_id = current_user[:id]

    if @gate.save
      redirect_to manage_gates_path, :flash =>{success:'新增成功！'} 
    else
      # 儲存失敗時借用 new 方法的頁面，不使用 redirect_to 方法使用者在輸入時的資料不會消失
      render :new, :flash =>{success:'新增失敗！'} 
    end
  end

  # 取出 Gate 資料中 id 是 params[:id] 的資料
  def edit
  end

  def update
    if @gate.update(gate_params)
      @gate.tag_list.add(params[:tag])
      @gate.save
      redirect_to manage_gates_path, :flash=>{success:'更新成功！'}
    else	
      render :edit, :flash=>{danger:'更新失敗！'} 
    end
  end

  def destroy
    @gate.destroy
    redirect_to manage_gates_path, :flash=>{success:'刪除成功！'} 
  end

  def search_tag
    @tags = ActsAsTaggableOn::Tag.most_used(20)
    #如果使用者沒輸入搜尋字
    if params[:search_word].empty?
      # 列出所有月門
      @gates = Gate.public_server.left_joins(:like_logs).group(:id).order('COUNT(like_logs.id)DESC').page(params[:page]).per(9)
    else 
      # 有輸入關鍵字對關鍵字查詢
      @gates = Gate.public_server.tagged_with(params[:search_word]).page(params[:page]).per(9)
      flash.now[:danger] ="目前並無搜尋到相關月門..." if @gates.empty?
    end
  end

  def manage
    @gates = User.find(current_user[:id]).gates.page(params[:page]).per(8)
  end

  def join_server
    url = URI("https://discordapp.com/api/guilds/#{params[:gate_server]}/widget.json")
    res = Net::HTTP.get_response(url)
    if res.is_a?(Net::HTTPSuccess) 
      link = JSON.parse(open("https://discordapp.com/api/guilds/#{params[:gate_server]}/widget.json").read)
    else
      redirect_to root_path
      flash[:danger] = '目前找不到伺服器，請確認伺服器 ID 是否正常？'   
      return
    end

    join_link = link['instant_invite']
    redirect_to join_link.to_s 
  end
  
  private
  # 利用 Strong Parameters 設定過濾參數
  def gate_params
    params.require(:gate).permit(:name, :icon, :intro, :intro_detail, :is_public, :like, :server, :tag_list, :user_id, :search_word)
  end
  # 每個 Action 撈出 route 對應資料庫 id 的參數
  def find_gate_id
    @gate = scoped.find(params[:id])
  end

  def scoped
    return Gate if current_user.admin? && ['update', 'edit', 'destroy'].include?(params[:action])
    current_user.gates
  end
end
