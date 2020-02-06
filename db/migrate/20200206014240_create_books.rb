# frozen_string_literal: true

class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title, null: false
      t.string :authors
      t.string :publisher
      t.date   :published_date
      t.string :image_url
      t.text   :description
      t.string :isbn_10
      t.string :isbn_13
      t.string :google_books_id, null: false

      t.timestamps
    end

    add_index :books, :google_books_id, unique: true
  end
end
