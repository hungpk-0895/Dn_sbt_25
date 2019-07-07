class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  belongs_to :payment
  enum status: {pending: 0, accept: 1}
  delegate :name, :place, :price, :start_time, :finish_time,
    to: :tour, prefix: true
  scope :sort_time, ->{order(created_at: :desc)}
  scope :load_book, ->(user_id){where(user_id: user_id)}
end
