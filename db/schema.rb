# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_22_032201) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "books", force: :cascade do |t|
    t.string "title", null: false
    t.string "authors"
    t.string "publisher"
    t.date "published_date"
    t.string "image_url"
    t.text "description"
    t.string "isbn_10"
    t.string "isbn_13"
    t.string "google_books_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bookshelf_books_count", default: 0, null: false
    t.integer "reviews_count", default: 0, null: false
    t.index ["google_books_id"], name: "index_books_on_google_books_id", unique: true
  end

  create_table "bookshelf_books", force: :cascade do |t|
    t.bigint "bookshelf_id", null: false
    t.bigint "book_id", null: false
    t.date "adding_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["bookshelf_id", "book_id"], name: "index_bookshelf_books_on_bookshelf_id_and_book_id", unique: true
  end

  create_table "bookshelves", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_bookshelves_on_user_id", unique: true
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "review_id", null: false
    t.bigint "user_id", null: false
    t.date "liked_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["review_id", "user_id"], name: "index_likes_on_review_id_and_user_id", unique: true
    t.index ["review_id"], name: "index_likes_on_review_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "followed_id", null: false
    t.bigint "follower_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["followed_id", "follower_id"], name: "index_relationships_on_followed_id_and_follower_id", unique: true
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.integer "rate", null: false
    t.bigint "book_id", null: false
    t.bigint "user_id", null: false
    t.datetime "reviewed_at", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "likes_count", default: 0, null: false
    t.index ["book_id"], name: "index_reviews_on_book_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "remember_digest"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookshelf_books", "books"
  add_foreign_key "bookshelf_books", "bookshelves"
  add_foreign_key "bookshelves", "users"
  add_foreign_key "likes", "reviews"
  add_foreign_key "likes", "users"
  add_foreign_key "relationships", "users", column: "followed_id"
  add_foreign_key "relationships", "users", column: "follower_id"
  add_foreign_key "reviews", "books"
  add_foreign_key "reviews", "users"
end
