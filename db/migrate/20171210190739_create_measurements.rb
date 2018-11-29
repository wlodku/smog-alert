class CreateMeasurements < ActiveRecord::Migration[5.0]
  def change
    create_table :measurements do |t|
      t.integer :pm1
      t.integer :pm25
      t.integer :pm10
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
