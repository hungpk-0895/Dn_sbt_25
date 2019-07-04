class StaticPagesController < ApplicationController
  def home
    @top_rates = Tour.top_rates
    @top_views = Tour.top_views
  end

  def about; end

  def news
    @new_tours =  Tour.new_tours.paginate(page: params[:page], per_page: 3)
  end

  def offers; end

  def contact; end
end
