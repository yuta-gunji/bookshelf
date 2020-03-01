# frozen_string_literal: true

class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: %i[create]

  def create
    set_book

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

  private

  def review_params
    params.require(:review).permit(
      :title,
      :content,
      :rate,
      :book_id
    ).merge(reviewed_at: Time.current)
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
