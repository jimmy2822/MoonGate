class AdminController < Admin::BaseController
    def dashboard
        @gates_total = Gate.all.count
        @users_total = User.all.count
    end

    def manage_gates
        @gates = Gate.all.page(params[:page]).per(50)
    end

    def manage_users
        @users = User.all.page(params[:page]).per(50)
    end 

    def destroy_mutiple
        Gate.destroy(params[:items_ids]) unless params[:items_ids].blank?
        redirect_to "/admin/manage_gates" 
    end

    def destroy_mutiple_user
        User.destroy(params[:items_ids]) unless params[:items_ids].blank?
        redirect_to "/admin/manage_users" 
    end
end
