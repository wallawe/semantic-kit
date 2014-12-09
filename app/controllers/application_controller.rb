class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #before_filter :restrict_to_coming_soon

  def current_user
    @current_user ||= lookup_user
  end
  helper_method :current_user

  def lookup_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end

  def authenticate
    logged_in? ? true : access_denied
  end

  def logged_in?
    current_user.is_a? User
  end
  helper_method :logged_in?

  def access_denied
    redirect_to signin_path, :notice => "Please log in to continue" and return false
  end

  def restrict_to_coming_soon
    redirect_to root_path unless permitted?
  end

  def permitted?
    current_user && current_user.admin? || request.path == root_path || controller_name == "sessions"
  end

end
