class AddColumnScoreInTours < ActiveRecord::Migration[5.2]
  def change
    add_column :tours, :score, :float, default: 0
  end
end
