class Tour < ApplicationRecord
  belongs_to :category
  has_many :bookings
  has_many :reviews

  scope :top_rates, ->{order(score: :desc).limit(4)}
  scope :top_views, ->{order(count_views: :desc).limit(8)}
  scope :new_tours, ->{order(created_at: :desc)}
end
