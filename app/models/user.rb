class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :subscriptions, dependent: :destroy
	has_many :installations, through: :subscriptions


  scope :activated, -> { where(is_active: true) }
  scope :not_spammed, -> { where("email_sent_at + delay*interval '1 hour' < :now OR email_sent_at is NULL",
												 	 now: Time.now) }

  after_create :add_subscriptions

  private
    def add_subscriptions
      Installation.all.each do |i|
        self.subscriptions.create(installation: i)
      end
    end
end
