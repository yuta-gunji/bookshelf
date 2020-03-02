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
      set_reviews_count
      set_adding_status
      render 'books/show'
    end
  end

  def edit
    @review = Review.includes(:book, :user).find(params[:id])
    redirect_to root_path unless current_user.id == @review.user_id
  end

  def update
    @review = Review.includes(:book, :user).find(params[:id])
    redirect_to root_path unless current_user.id == @review.user_id

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
    current_user.bookshelf.add!(book)
  end

  def set_book
    @book = Book.find(review_params[:book_id])
  end

  def set_reviews_count
    @reviews_number = @book.bookshelf_books.count
  end

  def set_adding_status
    @adding_status = current_user.bookshelf.books.include?(@book)
  end
end
