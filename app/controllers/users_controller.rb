# frozen_string_literal: true

class UsersController < ApplicationController
  include ActiveRecord::Sanitization::ClassMethods

  before_action :authenticate_user!, only: %i[edit update]

  def index
    users =
      if (@name = params[:name])
        User.where('lower(name) LIKE ?', "%#{sanitize_sql_like(@name.downcase)}%")
      else
        User.all
      end
    @users = users.with_attached_avatar.order(:name).page(params[:page])
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
    @books = @user.bookshelf.books.order('bookshelf_books.created_at').page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    check_user_validity(@user)
  end

  def update
    @user = User.find(params[:id])
    check_user_validity(@user)
    if @user.update(user_params)
      flash[:success] = I18n.t(:successfully_updated)
      redirect_to user_path(@user)
    else
      render :edit
    end
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
    @followings = @user.followings.with_attached_avatar.page(params[:page])
  end

  def followers
    @user = User.includes(:followers).find(params[:id])
    @books_count = books_count(@user)
    @reviews_count = reviews_count(@user)
    @followings_count = followings_count(@user)
    @followers_count = followers_count(@user)
    @followers = @user.followers.with_attached_avatar.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
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

  def check_user_validity(user)
    unless current_user?(user)
      flash[:danger] = I18n.t(:unauthorized)
      redirect_to root_path
    end
  end
end
