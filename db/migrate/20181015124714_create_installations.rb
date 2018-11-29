class CreateInstallations < ActiveRecord::Migration[5.0]
  def change
    create_table :installations do |t|
      t.string :name
      t.integer :sensor_id

      t.timestamps
    end
  end
end
