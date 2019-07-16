class Tour < ApplicationRecord
  belongs_to :category
  has_many :bookings
  has_many :reviews

  scope :top_rates, ->{order(score: :desc)}
  scope :top_views, ->{order(count_views: :desc)}
  scope :new_tours, ->{order(created_at: :desc)}
end
