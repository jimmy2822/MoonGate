module GatesHelper
    # 如果使用者為登入狀態，就顯示登出按鈕，否則顯示登入按鈕
    def sign_out
        if user_signed_in?
            link_to "Sign out", destroy_user_session_path, method: "delete"
        else
            link_to "Sign in", user_session_path, method: "get"
        end
    end

    # 顯示使用者歡迎信息
    def user_name
        if user_signed_in?
            "歡迎回來!【 " + current_user[:email] +" 】"
        else
        end
    end

    # 顯示登入和登出按鈕切換
    def like_gate_button(gate)
        if user_signed_in?
            link_to '喜歡', like_gate_path(gate),method:"like"
        else
            link_to '喜歡', user_session_path,method: "get"
        end
    end

    # 檢查 gate 的 user_id 是否和目前登入者相同
    def gate_owner?(gate)
        if gate[:user_id] == current_user[:id]
            flash[:notice] = "你有權限編輯!"
        else
            flash[:notice] = "權限不足!"
            redirect_to gates_path
        end
    end 
end
