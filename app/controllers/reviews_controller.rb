# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create edit update]

  def create
    set_book
    add_to_bookshelf(@book)
    @review = current_user.reviews.new(review_params)

    if @review.save
      flash[:success] = I18n.t(:successfully_created)
      redirect_to book_path(@book)
    else
      set_adding_status
      render 'books/show'
    end
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

  def add_to_bookshelf(book)
    current_user.bookshelf.add(book)
  end

  def set_book
    @book = Book.find(review_params[:book_id])
  end

  def set_adding_status
    @adding_status = current_user.bookshelf.books.include?(@book)
  end

  def check_user_validity(user)
    unless current_user?(user)
      flash[:danger] = I18n.t(:unauthorized)
      redirect_to root_path
    end
  end
end
