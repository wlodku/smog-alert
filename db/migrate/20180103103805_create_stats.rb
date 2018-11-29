class CreateStats < ActiveRecord::Migration[5.0]
  def change
    create_table :stats do |t|
      t.float :pm10
      t.float :pm25
      t.date :day
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
