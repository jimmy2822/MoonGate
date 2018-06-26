class ApplicationController < ActionController::Base
    def check_gate_owner(gate)
        if gate[:user_id] == current_user[:id]
            flash[:notice] = "你有權限編輯!"
        else
            flash[:notice] = "權限不足!"
            redirect_to gates_path
        end
    end
end
