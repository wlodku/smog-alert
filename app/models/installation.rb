class Installation < ApplicationRecord  
  has_many :measurements, dependent: :destroy
	has_many :subscriptions, dependent: :destroy
	has_many :users, through: :subscriptions
end
