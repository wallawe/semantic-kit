class ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def index
    @themes = Theme.all
  end

  def show
    @theme = Theme.find(params[:id])
  end
end
