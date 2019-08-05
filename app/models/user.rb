class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  before_save :downcase_email
  enum role: {guess: 0, admin: 1}

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_one :banking, dependent: :destroy
  has_one :other_login, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.valid.name.max_length}

  validates :email,
    format: {with: VALID_EMAIL_REGEX},
    length: {maximum: Settings.valid.email.max_length},
    presence: true, uniqueness: {case_sensitive: false}

  validates :phone, presence: true,
    numericality: true

  scope :sort_name, ->{order :name}

  def downcase_email
    email.downcase!
  end
end
