class AddIndexForNameTourToTour < ActiveRecord::Migration[5.2]
  def change
    add_index :tours, :name, unique: true
  end
end
