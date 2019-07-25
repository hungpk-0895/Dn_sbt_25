class Tour < ApplicationRecord
  belongs_to :category
  enum status: {openning: 0, full: 1, finished: 2}
  has_many :bookings
  has_many :reviews

  mount_uploader :picture, PictureUploader

  validates :name, presence: true,
    length: {maximum: Settings.valid.name.max_length}
  validates :description, presence: true
  validates :detail, presence: true
  validates :price, presence: true
  validates :place, presence: true
  validates :status, presence: true
  validates :start_time, presence: true
  validates :finish_time, presence: true

  scope :top_rates, ->{order(score: :desc)}
  scope :top_views, ->{order(count_views: :desc)}
  scope :new_tours, ->{order(created_at: :desc)}
end
