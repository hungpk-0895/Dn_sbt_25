class StaticPagesController < ApplicationController
  def home
    @top_rates = Tour.top_rates
                     .tour_opening
                     .limit Settings.limit_page.top_rates
    @top_views = Tour.top_views
                     .tour_opening
                     .limit Settings.limit_page.top_views
    @categories = Category.sub_categories
    @q = Tour.search(params[:q])
  end

  def about; end

  def news
    @new_tours = Tour.new_tours.tour_opening.paginate page: params[:page],
      per_page: Settings.limit_page.news
  end

  def offers; end

  def contact; end
end
