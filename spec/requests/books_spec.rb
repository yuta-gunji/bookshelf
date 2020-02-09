# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET #index' do
    let(:title) { 'awesome title' }
    let(:book) { create(:book, title: title) }
    it 'succeeds' do
      get books_path
      expect(response.status).to eq 200
      expect(response.body).to include title
    end
  end
end
