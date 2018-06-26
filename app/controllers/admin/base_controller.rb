module Admin
    class BaseController < ApplicationController
        before_action :authenticate_user!
        before_action :verify_admin

        private

        def verify_admin
            return if current_user.admin?
            redirect_to root_path, alert: "Your are not admin!"
        end
    end
end