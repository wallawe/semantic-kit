class ThemeApprovalsController < ApplicationController
  def update
    theme.approve!
    redirect_to theme_path(theme)
  end

  def destroy
    theme.disapprove!
    redirect_to theme_path(theme)
  end

  private

    def theme
      Theme.find(params[:id])
    end
end
