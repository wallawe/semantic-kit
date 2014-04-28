class InfoController < ApplicationController
  def home
    @themes = Theme.all
  end

  def help
  end
end
