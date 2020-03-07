# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bookshelf, type: :model do
  describe '#add(book)' do
    let(:bookshelf) { create(:bookshelf) }
    let(:book) { create(:book) }

    context 'when book has already added' do
      before { bookshelf.books << book }
      it 'does not change number of books on bookshelf' do
        expect { bookshelf.add(book) }.not_to change(bookshelf.books, :count)
      end
    end

    context 'when book is not added yet' do
      it 'changes number of books on bookshelf' do
        expect { bookshelf.add(book) }.to change { bookshelf.books.count }.by(1)
      end
    end
  end
end
