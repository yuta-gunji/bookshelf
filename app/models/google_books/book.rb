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
      @industry_identifiers = args[:industry_identifiers]
    end

    attr_reader :book_id, :title, :authors, :image_url, :publisher, :published_date, :description, :industry_identifiers
  end
end
