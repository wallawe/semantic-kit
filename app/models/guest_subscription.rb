class GuestSubscription < ActiveRecord::Base
  belongs_to :theme

  has_many :guest_downloads

  validates :token, presence: true

  def self.already_exists?(params)
    exists?(
      token: params[:guest_token],
      theme_id: params[:id],
      price_tier: params[:price]
    )
  end

  def self.random_token
    loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.exists?(token: random_token)
    end
  end

  def self.create_and_notify!(theme, params)
    subscription = self.create!(
      token:      params[:guest_token],
      email:      params[:payer_email],
      theme_id:   params[:id],
      price_tier: params[:price]
    )

    if subscription
      theme.sales_tracker.increment!(params[:count].to_sym)
      theme.sales_tracker.increment!(:sale_count)

      ThemeMailer.guest_purchase(theme, params[:payer_email], subscription.token).deliver
    end
  end

  def self.exists_and_downloadable?(theme_id, token)
    guest_account = guest_for_email_and_token(theme_id, token)
    return false if token.nil? || guest_account.nil?
    guest_account.downloadable?
  end

  def self.guest_for_email_and_token(theme_id, token)
    where(theme_id: theme_id, token: token).first
  end

  def downloadable?
    guest_downloads.count < Download::MAXIMUM_TRIES
  end
end
