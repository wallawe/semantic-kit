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

  def call_to_action(theme)
    if current_user
      if current_user.admin? && !theme.approved?
        render "approve_button"
      elsif current_user.can_download?(theme)
        render "download_button"
      else
        render "subscriptions/button"
      end
    elsif GuestSubscription.exists_and_downloadable?(params[:id], params[:token])
      render "download_button"
    else
      render "subscriptions/button"
    end
  end

  def paypal_url
    if Rails.env.production?
      ENV["paypal_url"]
    else
      APP_CONFIG["paypal"]["url"]
    end
  end

end
