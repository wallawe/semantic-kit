class ExposController < ApplicationController
  before_filter :authenticate, only: [:new, :create]

  def new
    @expo = Expo.new
  end

  def create
    expo = Expo.create(expo_params)
    if expo
      expo.assign_image!
      redirect_to expos_path, notice: "Your site #{expo.url} is in!"
    else
      redirect_to new_expo_path
    end
  end

  def index
    @expos = Expo.with_image.paginate(page: params[:page], per_page: 20).order('created_at DESC')
  end

  private

    def expo_params
      params.require(:expo).permit(:url)
    end
end
