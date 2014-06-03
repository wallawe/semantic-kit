class SubscriptionsController < ApplicationController
  def create
    theme = Theme.find_by_id(params[:id])

    # Stripe expects amount to be in cents
    amount = params[:price].to_i * 100

    subscription = current_user.subscriptions.create!(theme_id: params[:id], price_tier: params[:price])

    subscription.create_customer_and_charge(params[:token], amount)

    theme.pay_owner(amount)

    redirect_to theme_path(theme), notice: "WOOHOO"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to theme_path(theme)
  end

end
