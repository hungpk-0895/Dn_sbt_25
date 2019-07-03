class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :downcase_email

  has_secure_password

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :banking, dependent: :destroy
  has_one :other_login, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.valid.name.max_length}

  validates :password, presence: true, allow_nil: true,
    length: {minimum: Settings.valid.password.min_length}

  validates :email,
    format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.valid.email.max_length},
    presence: true, uniqueness: {case_sensitive: false}

  scope :sort_name, ->{order name: :desc}

  def downcase_email
    email.downcase!
  end
end
