class DashboardsController < ApplicationController
  def show
    @themes = current_user.themes
    @snippets = current_user.snippets
  end
end
