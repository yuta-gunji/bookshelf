# frozen_string_literal: true

module GoogleBooks
  class Response
    def initialize(faraday_response)
      @faraday_response = faraday_response
    end

    def found_books
      parsed_body['items'].map do |item|
        book_info = item['volumeInfo']

        Book.new(
          book_id: item['id'],
          title: book_info['title'],
          authors: book_info['authors'] || [],
          image_url: book_info['imageLinks'] ? book_info['imageLinks']['thumbnail'] : nil,
          publisher: book_info['publisher'],
          published_date: book_info['publishedDate'],
          description: book_info['description'],
          industry_identifiers: book_info['industryIdentifiers']
        )
      end
    end

    private

    def parsed_body
      JSON.parse(@faraday_response.body)
    end
  end
end
