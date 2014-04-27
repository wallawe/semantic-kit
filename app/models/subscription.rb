class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme
end
