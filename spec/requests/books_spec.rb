# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books', type: :request do
  describe 'GET #index' do
    let(:title_1) { 'awesome title' }
    let(:title_2) { 'another awesome title' }
    before do
      create(:book, title: title_1)
      create(:book, title: title_2)
    end

    it 'succeeds' do
      get books_path
      expect(response.status).to eq 200
    end

    it 'displays titles of books' do
      get books_path
      expect(response.body).to include title_1
      expect(response.body).to include title_2
    end
  end
end
