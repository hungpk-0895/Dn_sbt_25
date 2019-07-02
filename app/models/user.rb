class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :banking, dependent: :destroy
  has_one :other_login, dependent: :destroy

  scope :sort_name, ->{order name: :desc}
end
