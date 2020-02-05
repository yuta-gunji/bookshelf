# frozen_string_literal: true

class BooksController < ApplicationController
  def search
    if (@keyword = params[:keyword]).present?
      request = GoogleBooks::Request.new(params[:keyword])
      response = request.submit
      @books = response.found_books
    else
      @books = []
    end
  end
end
