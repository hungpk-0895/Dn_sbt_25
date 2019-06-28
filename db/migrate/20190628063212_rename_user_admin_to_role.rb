class RenameUserAdminToRole < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :admin, :role
  end
end
