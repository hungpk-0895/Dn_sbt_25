class CreateTours < ActiveRecord::Migration[5.2]
  def change
    create_table :tours do |t|
      t.string :name
      t.string :description
      t.string :picture
      t.text :detail
      t.string :place
      t.float :price
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :status
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end
