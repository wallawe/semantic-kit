class SubscriptionsController < ApplicationController
  def create
    theme = Theme.find_by_id(params[:id])

    # Stripe expects amount to be in cents
    amount = params[:price].to_i * 100

    customer = Stripe::Customer.create(
      :email => current_user.email,
      :card  => params[:token]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )

    subscription = current_user.subscriptions.create!(theme_id: params[:id])

    redirect_to theme_path(theme), notice: "WOOHOO"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to theme_path(theme)
  end

end
