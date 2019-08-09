class Admin::ToursController < ApplicationController
  authorize_resource
  before_action :admin_user
  before_action :load_tour, except: %i(index new create import)
  before_action :load_sub_categories, only: %i(new create edit)
  before_action :check_currency, only: %i(create update)

  def index
    @q = Tour.search(params[:q])
    @tours = @q.result.paginate page: params[:page],
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
      redirect_to admin_tours_path
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

  def import
    if params[:file].present?
      counter = Tour.import_file params[:file], params[:overwrite]
      render_flash(counter)
      flash[:success] = t(".created", counter: counter[:counter_created])
    else
      flash[:danger] = t(".error.fail")
    end
    redirect_to admin_tours_path
  end

  private
  def check_currency
    return if params[:locale] == Settings.locale_en
    price = params[:tour][:price].to_f
    price /= 22_000
    params[:tour][:price] = price
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

  def render_flash counter
    if params[:overwrite].present?
      flash[:info] = t(".updated.success", counter: counter[:counter_updated])
    else
      flash[:warning] = t(".updated.ignore", counter: counter[:counter_updated])
    end
    flash[:danger] = t(".error.data", c: counter[:counter_error_category],
      s: counter[:counter_error_status])
  end
end
