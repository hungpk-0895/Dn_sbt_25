class Admin::CategoriesController < ApplicationController
  before_action :load_category, only: %i(edit update destroy)
  before_action :load_parent_category, only: %i(new edit)

  def index
    @categories = Category.parent_cats.paginate page: params[:page]
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @category.parent_id ||= 0
    if @category.save
      flash[:success] = t ".success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t ".fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy
    if @category.parent_id.zero?
      delete_parent_category @category
    elsif @category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_to request.referer
  end

  private
  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".not_found_category"
    redirect_to root_path
  end

  def load_parent_category
    @parent_cats = Category.parent_cats
  end

  def delete_parent_category parent_category
    if parent_category.destroy
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
  end
end
