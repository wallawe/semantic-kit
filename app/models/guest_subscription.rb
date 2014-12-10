class GuestSubscription < ActiveRecord::Base
  belongs_to :theme

  def self.random_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.exists?(token: random_token)
    end
  end
end
