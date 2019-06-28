class CreateBankings < ActiveRecord::Migration[5.2]
  def change
    create_table :bankings do |t|
      t.text :information
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
