class GatesController < ApplicationController
    attr_accessor :gates
    before_action :find_gate_id 
    before_action :authenticate_user! ,only: [:edit, :destory , :new, :create]
    # 將 Gate Model 資料傳進實體變數 @gates
    def index
        @gates = Gate.all
    end

    def show       
    end

    # 在 Controller 設定實體變數 @gate 給 view 的 form_for 使用
    def new
        @gate = Gate.new
    end
    
    def create
        # 將已過濾的資料存進實體變數 @gate 當中
        @gate = Gate.new(gate_params)

        if @gate.save
            redirect_to gates_path, notice: "新增門成功"
        else
            # 儲存失敗時借用 new 方法的頁面，不使用 redirect_to 方法使用者在輸入時的資料不會消失
            render :new
        end
    end

    # 取出 Gate 資料中 id 是 params[:id] 的資料
    def edit
    end

    def update
        if @gate.update(gate_params) 
            redirect_to gate_path , notice: "更新成功"
        else
            render :edit, notice: "編輯失敗"
        end
    end

    def destroy
        @gate.destroy if @gate
        redirect_to gates_path, notice: "刪除成功"
    end

    def like
        @gate.like_logs.create(ip_address: request.remote_ip) if @gate
        redirect_to gates_path, notice: "喜歡成功!"
    end

    # 利用 Strong Parameters 設定過濾參數
    private
    def gate_params
        params.require(:gate).permit(:name, :icon, :tag, :intro, :intro_detail, :is_public, :like, :server).merge(user_id:current_user[:id])
    end

    def find_gate_id
          @gate = Gate.find_by(id: params[:id])
    end

end
