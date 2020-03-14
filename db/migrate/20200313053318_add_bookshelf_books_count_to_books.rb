# frozen_string_literal: true

class AddBookshelfBooksCountToBooks < ActiveRecord::Migration[6.0]
  def up
    add_column :books, :bookshelf_books_count, :integer, null: false, default: 0
    Book.find_each { |i| Book.reset_counters(i.id, :bookshelf_books_count) }
  end

  def down
    remove_column :books, :bookshelf_books_count, :integer
  end
end
