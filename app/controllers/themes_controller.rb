class ThemesController < ApplicationController
  before_filter :authenticate, only: [:new]

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      @theme.create_owner(user_id: User.first.id)
      redirect_to themes_path
    else
      render :new
    end
  end

  def index
    @themes = Theme.approved
  end

  def show
    @theme = Theme.find(params[:id])
  end

  private

    def theme_params
      params.require(:theme).permit(:name, :description, :copyright, { category_ids: [] },
                                    :image, :file_package, :tag_list,
                                    price_list_attributes: [:single_tier, :multiple_tier, :extended_tier])
    end
end
