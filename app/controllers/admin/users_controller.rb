module Admin
  class UsersController < Admin::BaseController 
    before_action :find_user_id, only: [:update, :destroy]
    def update
      if @user.save
        redirect_to admin_manage_users_path
      else
        render admin_manage_users_path
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_manage_users_path
    end

    private
    def find_user_id 
      @user = User.find(params[:id])
    end
  end
end
