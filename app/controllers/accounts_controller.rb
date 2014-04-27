class AccountsController < ApplicationController
  def show
    @subscriptions = current_user.subscriptions
  end
end
