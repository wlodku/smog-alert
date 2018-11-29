class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :email_sent_at, :datetime
  end
end
