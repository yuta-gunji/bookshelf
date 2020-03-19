# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update]

  def index
    @reviews = Review.includes(:book, :user, :likes).recent.page(params[:page])
  end

  def create
    book = Book.find(review_params[:book_id])
    current_user.bookshelf.add(book)
    review = current_user.reviews.new(review_params)
    review.save!
    flash[:success] = I18n.t(:successfully_created)
    redirect_to book_path(book)
  end

  def edit
    @review = Review.includes(:book, :user).find(params[:id])
    check_user_validity(@review.user)
  end

  def update
    @review = Review.includes(:book, :user).find(params[:id])
    check_user_validity(@review.user)

    if @review.update(review_params)
      flash[:success] = I18n.t(:successfully_updated)
      redirect_to book_path(@review.book)
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :title,
      :content,
      :rate,
      :book_id
    ).merge(reviewed_at: Time.current)
  end

  def check_user_validity(user)
    unless current_user?(user)
      flash[:danger] = I18n.t(:unauthorized)
      redirect_to user_path(current_user)
    end
  end
end
