class AddIsAdminToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :is_admin, :boolean, default: false
    rename_column :users, :isactive, :is_active
    change_column :users, :is_active, :boolean, default: true
    change_column :users, :critical, :integer, default: 2
  end
end
