# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.all.order(activated_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = I18n.t(:sent_email_for_account_activation)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @user = User.includes(:reviews, :active_relationships, bookshelf: :books).find(params[:id])
    @followings = @user.followings
    @followers = @user.followers
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
    )
  end
end
