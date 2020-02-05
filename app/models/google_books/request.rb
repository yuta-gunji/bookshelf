# frozen_string_literal: true

module GoogleBooks
  class Request
    MAX_RESULTS_NUMBER = 25

    def initialize(keyword)
      @keyword = keyword
    end

    def submit
      uri = URI.parse(base_url)
      res = Faraday.get(uri, params)
      GoogleBooks::Response.new(res)
    end

    private

    def base_url
      ENV.fetch('GOOGLE_BOOKS_API_URL')
    end

    def params
      {
        q: "intitle:#{@keyword}",
        maxResults: MAX_RESULTS_NUMBER
      }
    end
  end
end
