class AdminController < Admin::BaseController
    def dashboard
        @gates_total = Gate.all.count
        @users_total = User.all.count
    end

    def manage_gates
        @gates = Gate.all
    end

    def manage_users
        @users = User.all
    end 
end