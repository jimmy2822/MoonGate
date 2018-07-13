class LikesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_gate

    def create
        @gate.like_logs.create(user: current_user)
        redirect_to request.referrer
    end

    def destroy
        @gate.like_logs.by(current_user).destroy_all
        redirect_to request.referrer
    end
    
    private

    def find_gate
        @gate = Gate.find(params[:gate_id])
    end
end