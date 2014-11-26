class SalesTracker < ActiveRecord::Base
  belongs_to :theme

  def revenue
    0
    # single_tier_count * theme.price_list.single_tier +
    # multiple_tier_count * theme.price_list.multiple_tier +
    # extended_tier_count * theme.price_list.extended_tier
  end
end
