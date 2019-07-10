class Admin::BookingsController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user
  before_action :load_booking, except: %i(index)

  def index
    @bookings = Booking.sort_time.paginate page: params[:page],
      per_page: Settings.limit_page.booking
  end

  def accept_booking
    Booking.transaction do
      @booking.accepted!
      count_book = @booking.tour_count_book
      count_book += 1
      @booking.tour.update_attribute :count_book, count_book
      @booking.tour.save!
      flash[:success] = t ".success"
      redirect_to admin_bookings_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".fail"
    redirect_to admin_bookings_path
  end

  def reject_booking
    @booking.rejected!
    flash[:success] = t ".success"
    redirect_to admin_bookings_path
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".fail"
    redirect_to admin_bookings_path
  end

  def destroy
    Booking.transaction do
      @booking.destroy!
      if @booking.accepted?
        count_book = @booking.tour_count_book
        count_book -= 1
        @booking.tour.update_attribute :count_book, count_book
        @booking.tour.save!
      end
      flash[:success] = t ".success"
      redirect_to admin_bookings_path
    end
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = t ".fail"
    redirect_to admin_bookings_path
  end

  private
  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_booking
    booking_id = params[:id].present? ? params[:id] : params[:booking_id]
    @booking = Booking.find_by id: booking_id
    return if @booking
    flash[:danger] = t ".not_found"
    redirect_to admin_bookings_path
  end
end
