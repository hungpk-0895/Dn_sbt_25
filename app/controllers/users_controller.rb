class UsersController < ApplicationController
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

  def show
    @user = User.find_by(id: params[:id])
    return if @user
    flash[:warning] = t(".not_found", id: params[:id])
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :phone,
      :password, :password_confirmation)
  end
end
