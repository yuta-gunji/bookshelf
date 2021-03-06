# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_user?, :current_user?

  private

  def current_user
    if (user_id = session[:user_id])
      @_current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        login(user)
        @_current_user = user
      end
    end
  end

  def current_user?(user)
    user == current_user
  end

  def logged_in_user?
    !current_user.nil?
  end

  def login(user)
    session[:user_id] = user.id
  end

  def authenticate_user!
    unless logged_in_user?
      flash[:danger] = I18n.t(:please_login)
      redirect_to login_path
    end
  end
end
