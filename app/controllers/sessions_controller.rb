# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    flash[:info] = I18n.t(:already_logged_in)
    return redirect_to root_path if logged_in_user?
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      login(user)
      flash[:success] = I18n.t(:login_succeeded)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    reset_session
    flash[:success] = I18n.t(:logout_succeeded)
    redirect_to root_path
  end

  private

  def session_params
    params.require(:session).permit(
      :email,
      :password,
    )
  end

  def login(user)
    session[:user_id] = user.id
  end
end
