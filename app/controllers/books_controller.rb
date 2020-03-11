# frozen_string_literal: true

class BooksController < ApplicationController
  include ActiveRecord::Sanitization::ClassMethods

  def index
    @books =
      if (@keyword = params[:keyword])
        Book.where('lower(title) LIKE ?', "%#{sanitize_sql_like(@keyword.downcase)}%")
      else
        Book.all
      end
    @books = @books.recent.page(params[:page])
    @added_books_unique_ids = current_user.bookshelf.books.pluck(:google_books_id) if logged_in_user?
  end

  def show
    @book = Book.includes(reviews: %i[user likes]).find(params[:id])
    @reviews = @book.reviews.recent.page(params[:page])
    @added_count = @book.bookshelf_books.count
    @reviews_count = @book.reviews.count
    if logged_in_user?
      @adding_status = current_user.bookshelf.books.include?(@book)
      @review = Review.new
    end
  end

  def search
    if (@keyword = params[:keyword]).present?
      request = GoogleBooks::Request.new(params[:keyword])
      response = request.submit
      @books = response.found_books
      if logged_in_user?
        @books = @books.reject { |book| added_google_books_ids.include?(book.google_books_id) }
        flash[:info] = I18n.t(:result_is_empty) unless @books.present?
      end
    else
      @books = []
    end
  end

  private

  def added_google_books_ids
    current_user.bookshelf.books.pluck(:google_books_id)
  end
end
