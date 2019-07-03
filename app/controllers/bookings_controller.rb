class BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :load_tour, only: :new

  def index; end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new booking_params
    @tour = Tour.find_by id: params[:booking][:tour_id]
    save_booking @booking
  end

  private
  def save_booking booking
    if booking.save
      BookingMailer.notification(current_user, @tour).deliver_now
      flash[:success] = t ".pending"
    else
      flash[:danger] = t ".error"
    end
    redirect_to root_path
  end

  def load_tour
    @tour = Tour.find_by id: params[:tour_id]
    return if @tour
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def booking_params
    params.require(:booking).permit(:tour_id, :user_id, :payment_id)
  end
end
