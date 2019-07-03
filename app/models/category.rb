class Category < ApplicationRecord
  has_many :tours

  validates :name, presence: true, length: {maximum: Settings.valid.category.name.max_length}

  scope :parent_cats, ->{where(parent_id: 0)}
  scope :sub_cats, ->(id_cat){where(parent_id: id_cat)}
end
