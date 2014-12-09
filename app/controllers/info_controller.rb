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
    @will = User.where(email: "wallac.will@gmail.com").first
    @travis = User.where(email: "tvalent2@gmualumni.org").first
  end
end
