class DownloadsController < ApplicationController
  def create
    theme = Theme.find_by_id(params[:theme_id])

    if theme && current_user.can_download?(theme)
      current_user.downloads.create!(theme_id: theme.id)
      redirect_to theme.file_package.url
    else
      redirect_to theme_path(theme), notice: "You can't download at this time. Please contact help"
    end
  end

end
