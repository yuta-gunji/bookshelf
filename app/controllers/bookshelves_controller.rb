# frozen_string_literal: true

class BookshelvesController < ApplicationController
  def add_book
    book = find_or_create_book!
    current_user.bookshelf.add!(book)
    flash[:success] = I18n.t(:added_to_bookshelf)
    redirect_to root_path
  end

  private

  def book_params
    params.require(:book).permit(
      :google_books_id,
      :title,
      :authors,
      :image_url,
      :publisher,
      :published_date,
      :description,
      :isbn_10,
      :isbn_13
    )
  end

  def find_or_create_book!
    Book.find_or_create_by!(google_books_id: book_params[:google_books_id]) do |new_book|
      new_book.assign_attributes(book_params)
    end
  end
end
