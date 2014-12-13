class Download < ActiveRecord::Base
  MAXIMUM_TRIES = 5

  belongs_to :subscription
  belongs_to :theme
  belongs_to :user

  validates :subscription_id, presence: true
end
