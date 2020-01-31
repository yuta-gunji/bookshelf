# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :find_user!, only: %i[edit update]
  before_action :check_user_validity, only: %i[edit update]
  before_action :check_expiration, only: %i[edit update]

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

  def edit
  end

  def update
    if @user.update(user_params.merge(reset_digest: nil))
      login @user
      flash[:success] = I18n.t(:passwrod_has_been_reset)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def find_user!
    @user = User.find_by!(email: params[:email])
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = I18n.t(:password_reset_has_expired) + I18n.t(:retry_password_reset)
      redirect_to new_password_reset_path
    end
  end

  def check_user_validity
    if !@user.activated?
      flash[:danger] = I18n.t(:account_not_activated) + I18n.t(:activate_account)
      redirect_to root_path
    elsif !@user&.authenticated?(:reset, params[:id])
      flash[:danger] = I18n.t(:invalid_activation_link) + I18n.t(:retry_password_reset)
      redirect_to root_path
    end
  end

  def user_params
    params.require(:password_reset).permit(
      :password,
      :password_confirmation,
    )
  end
end
