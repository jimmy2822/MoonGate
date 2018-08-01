class AdminController < Admin::BaseController
  def dashboard
    @gates_total = Gate.all.count
    @users_total = User.all.count
  end

  def manage_gates
    if params[:search] 
      @gates = Gate.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(50)
    else
      @gates = Gate.all.page(params[:page]).per(50)
    end

    @gates = sort_gates(@gates) if params[:sort].present?
    @gates = @gates.page(params[:page]).per(50)
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

  def sort_gates(gates)
    params[:sort].reduce(gates) do |prev, sort|
      case sort
      when 'name' then prev.order(name: :asc)
      when 'created_at' then prev.order(created_at: :desc)
      else prev
      end
    end
  end

  private
  def find_gate_id
    Gate.find(params[:id])
  end

end
