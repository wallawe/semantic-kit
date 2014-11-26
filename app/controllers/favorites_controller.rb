class FavoritesController < ApplicationController
  def create
    favorite = current_user.favorites.create(
      favorited_id: params[:favorited_id],
      favorited_type: params[:favorited_type]
    )
    if favorite
      redirect_to_resource
    end
  end

  def destroy
    existing_favorite = current_user.favorites.where(
      favorited_id: params[:favorited_id],
      favorited_type: params[:favorited_type]
    ).first
    if existing_favorite.delete
      redirect_to_resource
    end
  end

  private

    def favorited_params
      params.require(:favorite).permit(:favorited_id, :favorited_type)
    end

    def redirect_to_resource
      case params[:favorited_type]
      when "Snippet"
        redirect_to snippet_path(Snippet.find(params[:favorited_id]))
      when "Theme"
        redirect_to theme_path(Theme.find(params[:favorited_id]))
      end
    end
end
