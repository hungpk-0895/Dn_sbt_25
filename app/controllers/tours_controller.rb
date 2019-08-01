class ToursController < ApplicationController
  authorize_resource
  before_action :find_tour, only: :show

  def index
    @q = Tour.search(params[:q])
    @tours = @q.result.paginate page: params[:page],
      per_page: Settings.limit_page.tour_search
  end

  def show
    @comment = Review.new
    @reply_comment = Review.new
  end

  private
  def find_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
