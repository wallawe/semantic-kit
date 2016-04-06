class ThemesController < ApplicationController
  before_filter :authenticate, only: [:new, :create, :destroy, :update, :edit]
  before_filter :get_theme, only: [:show, :edit, :update, :destroy, :preview ]

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    if @theme.save
      @theme.create_sales_tracker
      @theme.create_owner(user_id: current_user.id)
      redirect_to theme_path(@theme)
    else
      render :new
    end
  end

  def edit
    authorize(@theme)
  end

  def update
    authorize(@theme)
    if @theme.update_attributes(theme_params)
      redirect_to theme_path(@theme), notice: t(:"themes.updated")
    else
      render :edit
    end
  end

  def index
    @themes = Theme.approved.order('created_at desc').paginate(page: params[:page], per_page: 20)
  end

  def show
    @license = params[:license] || "single"
    if should_see_download_notice?
      flash[:notice] = t(:"downloads.reminder", name: @theme.name)
    end
  end

  def destroy
    authorize(@theme)
    @theme.destroy
    redirect_to themes_path, notice: 'Deletion successful'
  end

  def preview
    render layout: false
  end

  private
    def get_theme
      @theme = Theme.find(params[:id])
    end

    def authorize(theme)
      if !current_user.can_edit_theme?(theme)
        redirect_to themes_path
      end
    end

    def theme_params
      params.require(:theme).permit(:name, :description, :preview_url, :category_ids, { category_ids: [] },
                                    :image, :file_package, :tag_list, :preprocessor, { browsers: [] },
                                    price_list_attributes: [:single_tier, :multiple_tier, :extended_tier])
    end

    def should_see_download_notice?
      return if !params[:purchase_mailer]
      if current_user
        current_user.can_download?(@theme) || current_user.owns_theme?(@theme)
      elsif GuestSubscription.exists_and_downloadable?(params[:id], params[:token])
        true
      end
    end
end
