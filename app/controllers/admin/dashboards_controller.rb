class Admin::DashboardsController < ApplicationController

  def show
    redirect_to semantic_ui_themes_path unless current_user.admin?

    @themes = Theme.pending
  end
end