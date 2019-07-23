class AddSlotToTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :count_book, :integer, default: 0
    add_column :tours, :max_slot, :integer
  end
end
