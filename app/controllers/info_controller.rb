class InfoController < ApplicationController
  def home
    render layout: 'landing'
    @themes = Theme.all
  end

  def help
  end

  def sell
  end
end
