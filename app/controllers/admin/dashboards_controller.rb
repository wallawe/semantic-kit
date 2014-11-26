class Admin::DashboardsController < ApplicationController

  def show
<<<<<<< HEAD
    redirect_to semantic_ui_themes_path unless current_user.admin?
=======
    redirect_to themes_path unless current_user && current_user.admin?
>>>>>>> Add admin tables for themes, image to snippets

    @themes = Theme.pending
    @snippets = Snippet.all
  end
end