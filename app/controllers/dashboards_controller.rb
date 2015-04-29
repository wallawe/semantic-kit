class DashboardsController < ApplicationController
  before_filter :authenticate

  def show
    @themes = current_user.themes
    @snippets = current_user.snippets
  end
end
