class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :tour
  belongs_to :payment
  enum status: {pending: 0, accept: 1}
end
