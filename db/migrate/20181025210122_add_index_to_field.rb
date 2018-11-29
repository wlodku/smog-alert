class AddIndexToField < ActiveRecord::Migration[5.0]
  def change
  end
  add_index :measurements, :installation_id  
end
