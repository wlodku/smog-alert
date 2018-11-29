class AddEpochToMeasurement < ActiveRecord::Migration[5.0]
  def change
    add_column :measurements, :epoch, :string
  end
end
