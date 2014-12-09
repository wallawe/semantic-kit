class Admin::DashboardsController < ApplicationController

  def show
    redirect_to semantic_ui_themes_path unless current_user && current_user.admin?

    @themes = Theme.pending
    @expos  = Expo.pending
  end
end