# frozen_string_literal: true

class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      login(user)
      flash[:success] = I18n.t(:successfully_activated)
    else
      flash[:danger] = I18n.t(:invalid_activation_link)
    end
    redirect_to root_path
  end
end
