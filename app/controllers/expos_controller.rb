class ExposController < ApplicationController
  before_filter :authenticate, except: [:index]

  def new
    @expo = Expo.new
  end

  def create
    @expo = Expo.new(expo_params)
    @expo.user = current_user
    if @expo.save
      redirect_to expos_path, notice: "Your site has beens submitted. We'll email you upon approval"
    else
      render :new
    end
  end

  def edit
    redirect_to expos_path unless current_user && current_user.admin?
    @expo = Expo.find(params[:id])
  end

  def update
    redirect_to expos_path unless current_user && current_user.admin?

    expo = Expo.find(params[:id])

    if expo.update_attributes(expo_params)
      redirect_to expos_path, notice: t(:"expos.updated")
    else
      render :edit
    end
  end

  def index
    @expos = Expo.approved.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  private

  def expo_params
    params.require(:expo).permit(:user_id, :url, :image, :title)
  end
end
