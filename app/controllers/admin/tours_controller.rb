class Admin::ToursController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :load_tour, except: %i(index new create)
  before_action :load_sub_categories, only: %i(new create edit)

  def index
    @tours = Tour.new_tours.paginate page: params[:page],
      per_page: Settings.limit_page.booking
  end

  def new
    @tour = Tour.new
  end

  def create
    @tour = Tour.new tour_params
    if @tour.save
      flash[:success] = t ".success"
      redirect_to admin_tours_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @tour.update_attributes tour_params
      flash[:success] = t ".success"
      redirect_to admin_tour_path
    else
      render :edit
    end
  end

  def destroy
    if @tour.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to admin_tours_path
  end

  private
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def load_sub_categories
    @categories = Category.sub_categories
    return if @categories
    @categories = []
  end

  def tour_params
    params.require(:tour).permit(:name, :description, :picture, :detail,
      :place, :price, :start_time, :finish_time, :status, :category_id)
  end
end
