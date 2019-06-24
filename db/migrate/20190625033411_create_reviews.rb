class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :review_content
      t.datetime :review_at
      t.integer :reply_review
      t.integer :count_liked
      t.text :comment_content
      t.datetime :comment_at
      t.integer :reply_comment
      t.integer :rating_score
      t.references :user, foreign_key: true
      t.references :tour, foreign_key: true

      t.timestamps
    end
  end
end
