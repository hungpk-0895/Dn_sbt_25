class Admin::UsersController < ApplicationController
  before_action :load_user,  only: %i(destroy)
  before_action :admin_user, only: %i(destroy index)

  def index
    @users = User.sort_name.paginate(page: params[:page], per_page: Settings.limit_page.users).all
  end

  def destroy
    if @user.admin?
      flash[:danger] = t ".not_have_role"
      redirect_to root_path
    else
      if @user.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t".fail"
      end
      redirect_to request.referer
    end
  end

  private
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
