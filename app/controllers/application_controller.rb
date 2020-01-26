# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in_user?

  private

  def current_user
    return nil unless session[:user_id]

    @_current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in_user?
    !current_user.nil?
  end

  # @param user [User]
  def login(user)
    session[:user_id] = user.id
  end
end
