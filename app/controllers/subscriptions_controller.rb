class SubscriptionsController < ApplicationController
  def create
    theme = Theme.find_by_id(params[:id])

    amount = params[:price].to_i * 100

    subscription = current_user.subscriptions.create!(theme_id: params[:id], price_tier: params[:price])

    theme.sales_tracker.increment!(params[:count].to_sym) if params[:paypal]

    redirect_to theme_path(theme), notice: "Thanks for purchasing #{theme.name}"

  end
end
