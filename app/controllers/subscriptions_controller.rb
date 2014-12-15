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
      user.purchase_and_notify!(theme, params)

      redirect_to theme_path(theme), notice: "Thanks for purchasing #{theme.name}"
    elsif logged_out && !GuestSubscription.already_exists?(params)
      GuestSubscription.create_and_notify!(theme, params)

      redirect_to theme.file_package.url, notice: "Thanks for purchasing #{theme.name}"
    else
      redirect_to theme_path(theme), notice: "We couldn't process that. Please email help@semantickit.com so we can help you out."
    end
  end
end
