class AddFieldToStation < ActiveRecord::Migration[5.0]
  def change
    add_column :stations, :sensor_id, :integer
  end
end
