class ThemesController < ApplicationController
  before_filter :authenticate, only: [:new]

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      @theme.create_owner(user_id: current_user.id)
      current_user.create_stripe_account if current_user.stripe_account.nil?
      redirect_to new_payment_preference_path
    else
      render :new
    end
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def update
    theme = Theme.find(params[:id])
    if theme.update_attributes(theme_params)
      redirect_to theme_path(theme), notice: t(:"themes.updated")
    else
      render :edit
    end
  end

  def index
    @themes = Theme.approved
  end

  def show
    @license = params[:license] || "single"
    @theme = Theme.find(params[:id])
  end

  private

    def theme_params
      params.require(:theme).permit(:name, :description, { category_ids: [] },
                                    :image, :file_package, :tag_list, :preprocessor, { browsers: [] },
                                    price_list_attributes: [:single_tier, :multiple_tier, :extended_tier])
    end
end
