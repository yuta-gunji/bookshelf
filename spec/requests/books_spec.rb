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

  describe 'GET #show' do
    let(:book) { create(:book) }

    context 'when book exists' do
      it 'succeeds' do
        get book_path(book.id)
        expect(response.status).to eq 200
      end

      it 'displays title of target book' do
        get book_path(book.id)
        expect(response.body).to include book.title
      end
    end

    context 'when book does not exist' do
      subject { -> { get book_path(1) } }
      it { is_expected.to raise_error ActiveRecord::RecordNotFound }
    end
  end
end
