class CreateOtherLogins < ActiveRecord::Migration[5.2]
  def change
    create_table :other_logins do |t|
      t.string :fb_token
      t.string :gg_token
      t.string :tw_token
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
