module GatesHelper
    # 如果使用者為登入狀態，就顯示登出按鈕，否則顯示登入按鈕
    def sign_button
        if user_signed_in?
            link_to "會員登出", destroy_user_session_path, method: "delete"
        else
            link_to "會員登入", user_session_path
        end
    end

    # 顯示使用者歡迎信息
    def user_name
        if user_signed_in?
            @name = current_user[:email].split("@")
            "歡迎回來！ 【 #{@name[0]} 】 "
        else
        end
    end

    # 
    def like_gate_button(gate)
        if user_signed_in?
            if gate.like_logs.by(current_user).exists?
                link_to '', gate_like_path(gate), method: :delete, class:"glyphicon glyphicon-star"
            else
                link_to '', gate_like_path(gate), method: :post, class:"glyphicon glyphicon-star-empty"
            end
        else
            link_to '喜歡', user_session_path
        end
    end

    # 檢查是否為 gate 擁有者 id 與登入者 id 是否相同
    def gate_owner?(gate)
        if gate[:user_id] == current_user[:id]
            flash[:notice] = "你有權限編輯!"
        else
            flash[:notice] = "權限不足!"
            redirect_to gates_path
            false
        end
    end

    def search_tag_button(tag_list)
        @a = 1
        tag_list.each do |tag|
            if @a < (tag_list.length)
                concat link_to(tag, search_tag_gates_path(search_word: tag.to_s), class:"btn-tag") + " "
                @a += 1
            else
                concat link_to(tag, search_tag_gates_path(search_word: tag.to_s), class:"btn-tag ")
            end
        end
    end
    
    def register_button
        link_to '會員註冊', new_user_registration_path, class:"btn" unless user_signed_in?
    end
end
