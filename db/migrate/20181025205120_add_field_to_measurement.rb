class AddFieldToMeasurement < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :installation_id, :integer
  end
end
