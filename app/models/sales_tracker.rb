class SalesTracker < ActiveRecord::Base
  belongs_to :theme

  def revenue
    gross_sales * PriceList::THEME_CREATOR_PERCENTAGE
  end

  def revenue_explanation
    "(#{gross_sales} x #{(PriceList::THEME_CREATOR_PERCENTAGE * 100)}%)"
  end

  def gross_sales
    (single_tier_count || 0) * theme.price_list.single_tier +
    (multiple_tier_count || 0) * theme.price_list.multiple_tier +
    (extended_tier_count || 0) * theme.price_list.extended_tier
  end
end
