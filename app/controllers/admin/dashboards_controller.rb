class Admin::DashboardsController < ApplicationController

  def show
    redirect_to themes_path unless current_user.admin?

    @themes = Theme.pending
  end
end