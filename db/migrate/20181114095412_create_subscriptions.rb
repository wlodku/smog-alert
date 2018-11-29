class CreateSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :installation_id

      t.timestamps
    end
  	add_index :subscriptions, :installation_id
  	add_index :subscriptions, :user_id
  end
end
