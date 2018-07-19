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
end