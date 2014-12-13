class GuestDownload < ActiveRecord::Base
  belongs_to :guest_subscription
  belongs_to :theme

  validates :guest_subscription_id, presence: true
end
