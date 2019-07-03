class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  attr_accessor :remember_token
  before_save :downcase_email
  enum role: {guess: 0, admin: 1}
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

  scope :sort_name, ->{order :name}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def authenticated? attribute, token
    digest = send("#{attribute}_digest")
    return false unless digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def downcase_email
    email.downcase!
  end
end
