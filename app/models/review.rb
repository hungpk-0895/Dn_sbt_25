class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tour

  delegate :name, to: :user, prefix: true

  scope :score_rate, ->(tour_id){where(tour_id: tour_id)}
  scope :parent_review, ->{where(reply_review: 0)}
  scope :sub_review, ->(review_ids){where(reply_review: review_ids)}
  scope :parent_comment, ->{where(reply_comment: 0)}
  scope :sub_comment, ->(comment_ids){where(reply_comment: comment_ids)}
end
