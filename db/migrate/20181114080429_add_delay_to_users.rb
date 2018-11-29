class AddDelayToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :delay, :integer, default: 8
  end
end
