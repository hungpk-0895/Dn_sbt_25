class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  scope :score_rate, ->(tour_id){where(tour_id: tour_id)}

  # def rating_score tour
  #   arr_score = Review.score_rate(tour.id)
  #   score = 0
  #   arr_score.each do |n|
  #     score += n
  #   end
  #   score /= arr_score.count
  # end
end
