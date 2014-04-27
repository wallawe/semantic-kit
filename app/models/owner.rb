class Owner < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  delegate :username,
    to: :user
end
