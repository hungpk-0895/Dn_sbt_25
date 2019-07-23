class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :load_users, only: :index
  before_action :find_user, only: :destroy

  def index; end

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
    return if current_user.admin?
    flash[:danger] = t ".not_have_permission"
    redirect_to root_path
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_users
    @users = User.sort_name.paginate page: params[:page],
      per_page: Settings.limit_page.users
  end
end
