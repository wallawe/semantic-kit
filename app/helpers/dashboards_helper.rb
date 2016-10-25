module DashboardsHelper
  def revenue_explanation_for(theme)
    "(#{number_to_currency(theme.gross_sales)} x #{(PriceList::THEME_CREATOR_PERCENTAGE * 100)}%)"
  end

  def formatted_sales_by_price_for(theme)
    theme.sales_tracker.sales_grouped_by_price.map{|k,v| "#{number_to_currency(k)} (#{v})"}.join(", ")
  end
end
