class AddColumnsToModel < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :qi, :integer
    add_column :users, :isactive, :boolean
    add_column :users, :critical, :integer
  end
end
