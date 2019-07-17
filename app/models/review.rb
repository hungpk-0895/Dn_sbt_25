class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  scope :score_rate, ->(tour_id){where(tour_id: tour_id)}
end
