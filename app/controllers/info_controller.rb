class InfoController < ApplicationController
  def home
    render layout: 'landing'
    @themes = Theme.all
  end

  def help
  end

  def sell
  end

  def faq
  end

  def privacy_policy
  end

  def terms
  end

  def about
  end
end
