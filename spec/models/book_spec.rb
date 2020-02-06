# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:book) { build(:book) }

  describe 'validations' do
    context 'when valid book' do
      it { expect(book).to be_valid }
    end

    context 'without title' do
      let(:invalid_book) { build(:book, title: '') }
      it { expect(invalid_book).not_to be_valid }
    end

    context 'without google_books_id' do
      let(:invalid_book) { build(:book, google_books_id: '') }
      it { expect(invalid_book).not_to be_valid }
    end

    context 'when google_books_id does not unique' do
      let(:book) { create(:book) }
      let(:duplicate_book) { book.dup }
      it { expect(duplicate_book).not_to be_valid }
    end
  end
end
