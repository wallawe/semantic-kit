class PriceList < ActiveRecord::Base
  THEME_CREATOR_PERCENTAGE = 0.75

  belongs_to :theme
end
