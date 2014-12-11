class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  has_many :downloads

  def has_remaining_downloads?
    downloads.where(theme_id: theme.id).count < Download::MAXIMUM_TRIES
  end

end
