class SalesTracker < ActiveRecord::Base
  belongs_to :theme

  def revenue
    gross_sales * 0.3
  end

  def gross_sales
    (single_tier_count || 0) * theme.price_list.single_tier +
    (multiple_tier_count || 0) * theme.price_list.multiple_tier +
    (extended_tier_count || 0) * theme.price_list.extended_tier
  end
end
