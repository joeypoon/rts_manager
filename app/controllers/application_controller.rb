class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_user(user)
    session[:user_id] = user.id
  end

  def current_user
    User.find_by id: session[:user_id]
  end

  def authenticate_user
    redirect_to login_path if current_user.nil?
  end
end
