# frozen_string_literal: true

class BooksController < ApplicationController
  def search
    if (@keyword = params[:keyword]).present?
      request = GoogleBooks::Request.new(params[:keyword])
      response = request.submit
      @books = response.found_books
      if logged_in_user?
        added_google_books_ids = current_user.bookshelf.books.pluck(:google_books_id)
        @books = @books.reject { |book| added_google_books_ids.include?(book.google_books_id) }
      end
    else
      @books = []
    end
  end
end
