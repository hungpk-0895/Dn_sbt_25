class ToursController < ApplicationController
  before_action :find_tour, only: :show

  def show; end

  private
  def find_tour
    @tour = Tour.find_by id: params[:id]
    return if @tour
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
