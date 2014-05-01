module ThemesHelper
  def theme_price_in_cents(price_list, license)
    case license
    when "single"
      price = price_list.single_tier
    when "multiple"
      price = price_list.multiple_tier
    when "extended"
      price = price_list.extended_tier
    end

    price.to_i * 100
  end
end
