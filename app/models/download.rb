class Download < ActiveRecord::Base
  MAXIMUM_TRIES = 5

  belongs_to :user
  belongs_to :theme

  validates :user_id, :theme_id, presence: true
end
