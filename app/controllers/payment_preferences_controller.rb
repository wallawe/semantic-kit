class PaymentPreferencesController < ApplicationController
  def new
  end

  def create
    # if card
    current_user.stripe_account.update_from_card(params[:stripeToken])
    redirect_to themes_path
    # if bank_account
    # current_user.stripe_account.update_from_bank_account(token)
  end
end
