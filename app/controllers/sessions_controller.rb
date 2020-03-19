# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    return redirect_to user_path(current_user) if logged_in_user?
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      if user.activated?
        login(user)
        update_remember_status(user)
        flash[:success] = I18n.t(:login_succeeded)
        redirect_to user_path(user)
      else
        flash[:warning] = I18n.t(:account_not_activated) + I18n.t(:check_email_for_activation_link)
        redirect_to login_path
      end
    else
      render :new
    end
  end

  def destroy
    logout if logged_in_user?
    flash[:success] = I18n.t(:logout_succeeded)
    redirect_to login_path
  end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password,
      :remember_me,
    )
  end

  def logout
    forget(current_user)
    reset_session
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def update_remember_status(user)
    session_params[:remember_me] == '1' ? remember(user) : forget(user)
  end
end
