module DashboardsHelper
  def formatted_sales_by_price_for(theme)
    theme.sales_tracker.sales_grouped_by_price.map{|k,v| "#{number_to_currency(k)} (#{v})"}.join(", ")
  end
end
