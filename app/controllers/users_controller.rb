# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(activated_at: :desc).page(params[:page])
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
    @user = User.includes(bookshelf: :books).find(params[:id])
    @books_count = books_count(@user)
    @reviews_count = reviews_count(@user)
    @followings_count = followings_count(@user)
    @followers_count = followers_count(@user)
    @books = @user.bookshelf.books
  end

  def reviews
    @user = User.includes(reviews: :book).find(params[:id])
    @books_count = books_count(@user)
    @reviews_count = reviews_count(@user)
    @followings_count = followings_count(@user)
    @followers_count = followers_count(@user)
    @reviews = @user.reviews.recent.page(params[:page])
  end

  def followings
    @user = User.includes(:followings).find(params[:id])
    @books_count = books_count(@user)
    @reviews_count = reviews_count(@user)
    @followings_count = followings_count(@user)
    @followers_count = followers_count(@user)
    @followings = @user.followings.page(params[:page])
  end

  def followers
    @user = User.includes(:followers).find(params[:id])
    @books_count = books_count(@user)
    @reviews_count = reviews_count(@user)
    @followings_count = followings_count(@user)
    @followers_count = followers_count(@user)
    @followers = @user.followers.page(params[:page])
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

  def books_count(user)
    user.bookshelf.books.count
  end

  def reviews_count(user)
    user.reviews.count
  end

  def followings_count(user)
    user.followings.count
  end

  def followers_count(user)
    user.followers.count
  end
end
