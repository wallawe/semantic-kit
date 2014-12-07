class ExposController < ApplicationController
  before_filter :authenticate, only: [:new, :create]

  def new
    @expo = Expo.new
  end

  def create
    @expo = Expo.new(expo_params)
    if @expo.save
      redirect_to expos_path, notice: "Your site #{@expo.url} is in!"
    else
      render :new
    end
  end

  def index
    @expos = Expo.paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  private

  def expo_params
    params.require(:expo).permit(:user_id, :url, :image)
  end
end
