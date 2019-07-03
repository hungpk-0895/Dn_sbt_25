class AddDefaultValueParentId < ActiveRecord::Migration[5.2]
  def change
    change_column :categories, :parent_id, :integer, default: 0
  end
end
