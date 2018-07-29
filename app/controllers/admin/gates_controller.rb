module Admin
  class GatesController < Admin::BaseController
    before_action :find_gate_id , only: [:show, :edit, :update,  :destroy]

    def show 
      
    end

    def edit
      
    end
    
    def new
      @gate = Gate.new
    end

    def create
      if Gate.create(gate_params)
        redirect_to admin_manage_gates_path
      else 
        render new
      end
    end
    
    def update
      if @gate.update(gate_params)
        redirect_to admin_manage_gates_path
      else 
        render edit
      end
    end

    def destroy
      @gate.destroy
      redirect_to '/admin/manage_gates'
    end

    private
    def gate_params
      params.require(:gate).permit(:name, :icon, :intro, :intro_detail, :is_public, :like, :server, :tag_list, :user_id, :search_word)
    end
    
    def find_gate_id
      @gate = Gate.find(params[:id])
    end
  end
end
