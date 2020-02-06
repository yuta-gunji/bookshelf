# frozen_string_literal: true

module GoogleBooks
  class Book
    def initialize(args)
      @book_id = args[:book_id]
      @title = args[:title]
      @authors = args[:authors]
      @image_url = args[:image_url]
      @publisher = args[:publisher]
      @published_date = args[:published_date]
      @description = args[:description]
      @isbn10 = args[:isbn10]
      @isbn13 = args[:isbn13]
    end

    attr_reader :book_id, :title, :authors, :image_url, :publisher, :published_date, :description, :isbn10, :isbn13
  end
end
