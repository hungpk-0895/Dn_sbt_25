module BookingsHelper
  def load_tour tour_id
    @tour = Tour.find_by id: tour_id
  end
end
