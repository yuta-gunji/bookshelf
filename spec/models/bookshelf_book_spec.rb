# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookshelfBook, type: :model do
  describe 'validations' do
    context 'when valid' do
      before do
        book = create(:book)
        bookshelf = create(:bookshelf)
        @bookshelf_book = build(:bookshelf_book, book_id: book.id, bookshelf_id: bookshelf.id)
      end
      it { expect(@bookshelf_book).to be_valid }
    end

    context 'without book_id' do
      let(:invalid_bookshelf_book) { build(:bookshelf_book, book_id: '') }
      it { expect(invalid_bookshelf_book).not_to be_valid }
    end

    context 'without bookshelf_id' do
      let(:invalid_bookshelf_book) { build(:bookshelf_book, bookshelf_id: '') }
      it { expect(invalid_bookshelf_book).not_to be_valid }
    end

    context 'without adding_date' do
      let(:invalid_bookshelf_book) { build(:bookshelf_book, adding_date: '') }
      it { expect(invalid_bookshelf_book).not_to be_valid }
    end

    context 'when conbination book_id and bookshelf_id does not unique' do
      let(:bookshelf_book) { create(:bookshelf_book) }
      let(:duplicate_bookshelf_book) { bookshelf_book.dup }
      it { expect(duplicate_bookshelf_book).not_to be_valid }
    end
  end
end
