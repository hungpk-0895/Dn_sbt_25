class SearchsController < ApplicationController
  def index
    @tour_searchs = Tour.search_place(params[:keyword])
                        .paginate page: params[:page],
                          per_page: Settings.limit_page.tour
  end
end
