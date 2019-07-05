class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show create new)
  before_action :load_user, except: %i(create new)
  before_action :correct_user, only: %i(edit update)
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = "Register Success"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def show; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".success"
      redirect_to user_path
    else
      render :edit
    end
  end

  private
  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :phone,
      :password, :password_confirmation)
  end
end
