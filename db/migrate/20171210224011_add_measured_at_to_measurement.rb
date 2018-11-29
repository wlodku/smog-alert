class AddMeasuredAtToMeasurement < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :measured_at, :datetime
  end
end
