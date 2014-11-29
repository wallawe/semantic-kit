class PriceList < ActiveRecord::Base
  THEME_CREATOR_PERCENTAGE = 0.70

  validates :single_tier, :multiple_tier, :extended_tier, :presence => true

  belongs_to :theme
end
