# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_user?

  private

  def current_user
    if (user_id = session[:user_id])
      @_current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(cookies[:remember_token])
        login(user)
        @_current_user = user
      end
    end
  end

  def logged_in_user?
    !current_user.nil?
  end

  def login(user)
    session[:user_id] = user.id
  end
end
