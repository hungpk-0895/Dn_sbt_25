class AddCountViewsToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :count_views, :integer, default: 0
  end
end
