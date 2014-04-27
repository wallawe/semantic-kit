class SubscriptionsController < ApplicationController
  def create
    subscription = current_user.subscriptions.new(theme_id: params[:id])
    if subscription.save

    end
  end
end
