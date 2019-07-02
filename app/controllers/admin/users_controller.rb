class UsersController < ApplicationController
  def index
    @users = User.sort_name.paginate(page: params[:page]).all
  end
end
