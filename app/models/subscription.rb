class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :theme

  has_many :downloads, dependent: :destroy

  def has_remaining_downloads?(theme)
    downloads.where(theme_id: theme.id).count < Download::MAXIMUM_TRIES
  end

end
