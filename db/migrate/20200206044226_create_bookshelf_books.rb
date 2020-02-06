# frozen_string_literal: true

class CreateBookshelfBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookshelf_books do |t|
      t.bigint :bookshelf_id, null: false
      t.bigint :book_id, null: false
      t.date   :adding_date, null: false

      t.timestamps
    end

    add_foreign_key :bookshelf_books, :bookshelves
    add_foreign_key :bookshelf_books, :books
    add_index :bookshelf_books, %i[bookshelf_id book_id], unique: true
  end
end
