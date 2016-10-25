class SalesTracker < ActiveRecord::Base
  belongs_to :theme

  def revenue
    gross_sales * PriceList::THEME_CREATOR_PERCENTAGE
  end

  def gross_sales
    subscription_sales + guest_subscription_sales
    # (single_tier_count || 0) * theme.price_list.single_tier +
    # (multiple_tier_count || 0) * theme.price_list.multiple_tier +
    # (extended_tier_count || 0) * theme.price_list.extended_tier
  end

  def subscription_sales
    subscriptions.map{|s| s.price_tier.to_f}.reduce(:+)
  end

  def guest_subscription_sales
    guest_subscriptions.map{|gs| gs.price_tier.to_f}.reduce(:+)
  end

  def sales_grouped_by_price
    new_hash = Hash.new
    (guest_subscriptions + subscriptions).group_by(&:price_tier).map {|k,v| new_hash[k.to_f] = v.count }
    new_hash
  end

  private

    def guest_subscriptions
      theme.guest_subscriptions
    end

    def subscriptions
      theme.subscriptions
    end
end
