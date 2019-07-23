module BookingsHelper
  def load_tour tour_id
    @tour = Tour.find_by id: tour_id
  end

  def load_user_book_tour user_id
    @user = User.find_by id: user_id
  end
end
