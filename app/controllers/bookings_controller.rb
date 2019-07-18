class BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :load_booking, only: :destroy
  before_action :load_tour, only: :new

  def index
    @bookings = Booking.load_book(current_user.id)
                       .sort_time
                       .paginate page: params[:page],
                          per_page: Settings.limit_page.booking
  end

  def new
    @booking = Booking.new
  end

  def create
    @booking = current_user.bookings.build booking_params
    @tour = Tour.find_by id: params[:booking][:tour_id]
    save_booking @booking
  end

  def destroy
    if @booking.pending?
      if @booking.destroy
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".fail"
      end
    else
      flash[:danger] = t ".error"
    end
    redirect_to bookings_path
  end

  private
  def booking_params
    params.require(:booking).permit(:tour_id, :payment_id)
  end

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

  def load_booking
    @booking = Booking.find_by id: params[:id]
    return if @booking
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
