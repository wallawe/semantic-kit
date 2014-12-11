class SubscriptionsController < ApplicationController
  # This allows the PayPal callback to fire as expected
  skip_before_action :verify_authenticity_token

  def create
    theme      = Theme.find_by_id(params[:id])
    amount     = params[:price].to_i * 100
    user       = current_user || User.find_by_id(params[:user_id])
    logged_out = params[:logged_out] && params[:logged_out] == "true"

    # if there is a user and they didn't purchase the theme,
    # create subscription and increment
    #
    # if the user is logged out and there isn't a GuestSubscription
    # create GuestSubscription and increment
    if user && user.can_purchase?(theme)
      subscription = user.subscriptions.create!(
        theme_id: params[:id],
        price_tier: params[:price]
      )

      if params[:paypal]
        theme.sales_tracker.increment!(params[:count].to_sym)
        theme.sales_tracker.increment!(:sale_count)
      end

      notice = "Thanks for purchasing #{theme.name}"
    elsif logged_out && !GuestSubscription.already_exists?(params)
      subscription = GuestSubscription.create!(
        token:      params[:guest_token],
        theme_id:   params[:id],
        price_tier: params[:price]
      )

      theme.sales_tracker.increment!(params[:count].to_sym)
      theme.sales_tracker.increment!(:sale_count)

      notice = "Thanks for purchasing #{theme.name}"
    else
      notice = "We couldn't process that. Please email help."
    end

    redirect_to theme_path(theme), notice: notice
  end
end
