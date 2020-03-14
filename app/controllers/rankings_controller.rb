# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @books_for_added_ranking = Book.added.order(bookshelf_books_count: :desc).limit(8)
    @books_for_reviewed_ranking = Book.reviewed.order(reviews_count: :desc).limit(8)
    @added_books_unique_ids = current_user.bookshelf.books.pluck(:google_books_id) if logged_in_user?
  end
end
