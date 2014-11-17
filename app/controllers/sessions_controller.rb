class SessionsController < ApplicationController
  skip_before_filter :authenticate
  layout "landing"

  def new
  end

  def create
    if user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to themes_path, :notice => t(:"sessions.successful_login")
    else
      flash.now[:alert] = t(:"sessions.invalid_login")
      render :action => 'new'
    end
  end

  def destroy
    reset_session
    cookies.delete(:auth_token)
    redirect_to root_path
  end
end
