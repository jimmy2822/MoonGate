class GatesController < ApplicationController
	before_action :authenticate_user! ,only: [:edit, :destory , :new, :create, :manage]
    before_action :find_gate_id, except: [:index, :show, :new, :create, :search_tag, :manage ]
    
    # 將 Gate Model 資料傳進實體變數 @gates
    def index
        @gates = Gate.includes(:user, :like_logs, :taggings, :tags)
        @gates = Gate.left_joins(:like_logs).group(:id).order('COUNT(like_logs.id)DESC')
		@tags = ActsAsTaggableOn::Tag.most_used(15)
    end

    def show  
        @gate = Gate.find(params[:id])     
    end

    # 在 Controller 設定實體變數 @gate 給 view 的 form_for 使用
    def new
        @gate = Gate.new
    end
    
    # 將已過濾的資料存進實體變數 @gate 當中
    def create
		@gate = Gate.new(gate_params)
        @gate.user_id = current_user[:id]

        if @gate.save
            redirect_to gates_path, notice: "新增門成功"
        else
            # 儲存失敗時借用 new 方法的頁面，不使用 redirect_to 方法使用者在輸入時的資料不會消失
			render :new, notice: "新增門失敗"
		end
    end

    # 取出 Gate 資料中 id 是 params[:id] 的資料
    def edit
    end
	
	def update
		if @gate.update(gate_params)
			@gate.tag_list.add(params[:tag])
			@gate.save
			redirect_to gates_path, notice: "編輯 SUCCESS!"
		else	
			render :edit, notice: "編輯失敗"
		end
    end

	def destroy
        @gate.destroy
        redirect_to gates_path 
        # redirect_to gates_path, notice: "刪除成功"
	end
	
	def search_tag
		@gates = Gate.tagged_with(params[:search_word])
    end
    
    def manage
        @gates = User.find(current_user[:id]).gates
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
