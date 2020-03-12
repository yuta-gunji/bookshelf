# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookshelfBook, type: :model do
  describe 'validations' do
    let(:user) { create(:user) }
    let(:book) { create(:book) }

    context 'when valid' do
      let(:bookshelf_book) { build(:bookshelf_book, bookshelf_id: user.bookshelf.id, book_id: book.id) }
      it { expect(bookshelf_book).to be_valid }
    end

    context 'without book_id' do
      let(:invalid_bookshelf_book) { build(:bookshelf_book, bookshelf_id: user.bookshelf.id, book_id: '') }
      it { expect(invalid_bookshelf_book).not_to be_valid }
    end

    context 'without bookshelf_id' do
      let(:invalid_bookshelf_book) { build(:bookshelf_book, bookshelf_id: '', book_id: book.id) }
      it { expect(invalid_bookshelf_book).not_to be_valid }
    end

    context 'when conbination book_id and bookshelf_id does not unique' do
      let(:bookshelf_book) { create(:bookshelf_book, bookshelf_id: user.bookshelf.id, book_id: book.id) }
      let(:duplicate_bookshelf_book) { bookshelf_book.dup }
      it { expect(duplicate_bookshelf_book).not_to be_valid }
    end
  end
end
