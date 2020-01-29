# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      UserMailer.password_reset(@user).deliver_now
      flash[:info] = I18n.t(:sent_password_reset_link)
      redirect_to root_path
    else
      flash.now[:danger] = I18n.t(:email_address_not_found)
      render :new
    end
  end
end
