class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  belongs_to :payment
  delegate :name, :place, :price, :start_time, :finish_time, :count_book,
    to: :tour, prefix: true
  delegate :name, :email, to: :user, prefix: true
  enum status: {pending: 0, accepted: 1, rejected: 2}
  scope :sort_time, ->{order(created_at: :desc)}
  scope :load_book, ->(user_id){where(user_id: user_id)}
end
