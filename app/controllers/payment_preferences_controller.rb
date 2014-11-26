class PaymentPreferencesController < ApplicationController
  def new
  end

  def create
    token = params[:stripeToken]

    if params[:type] == "card"
      current_user.stripe_account.update_from_card(token)
      redirect_to semantic_ui_themes_path
    elsif params[:type] == "bank_account"
      current_user.stripe_account.update_from_bank_account(token)
      redirect_to semantic_ui_themes_path
    end
  end
end
