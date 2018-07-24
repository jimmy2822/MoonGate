module GatesHelper
  # 如果使用者為登入狀態，就顯示登出按鈕，否則顯示登入按鈕
  def sign_button
    if user_signed_in?
      @name = current_user[:email].split("@")
      link_to content_tag(:i, " 會員登出 ( #{@name[0]} )", class:"fa fa-user"), destroy_user_session_path, method: "delete"
    else
      link_to content_tag(:i," 會員登入",class:"fa fa-user"), user_session_path
    end
  end

  # 顯示喜愛月門按鈕
  def like_gate_button(gate)
    if user_signed_in?
      if gate.like_logs.by(current_user).exists?
        link_to content_tag(:i, gate.like_logs.count, class:"fa fa-heart").html_safe, gate_like_path(gate), method: :delete, class:"btn-tag-like"
      else
        link_to content_tag(:i, gate.like_logs.count, class:"fa fa-heart-o").html_safe, gate_like_path(gate), method: :post, class:"btn-tag-like"
      end
    else
      link_to content_tag(:i, gate.like_logs.count, class:"fa fa-heart-o").html_safe, user_session_path, class:"btn-tag-like"
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

  #顯示月門相關標籤
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

  #未登錄時顯示註冊按鈕
  def register_button
    link_to content_tag(:i," 會員註冊",class:"fa fa-address-card"), new_user_registration_path  unless user_signed_in?
  end

  def show_gate_icon(gate)
    if gate.icon.to_s.empty?
      image_tag("default_gate_icon.jpg",class:"gate-icon")
    else
      link_to cl_image_tag(gate.icon, width:50, height:50, radius:"max" ),gate_path(gate),target:"_blank"
    end
  end

  def show_add_gate_tip
    flash.now[:notice]="您目前尚未擁有月門，請點選新增月門按鈕" if current_user.gates.count == 0
  end
end
