# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 33) do

  create_table "accessories", :force => true do |t|
    t.string  "accessory",                                            :default => "", :null => false
    t.integer "price",     :limit => 8, :precision => 8, :scale => 0
    t.string  "image"
    t.integer "width"
    t.integer "height"
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.text     "description"
    t.string   "keywords"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active",      :default => false
  end

  create_table "images", :force => true do |t|
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "links", :force => true do |t|
    t.integer "position"
    t.string  "url"
    t.string  "title"
    t.text    "desc"
    t.string  "logo_image"
    t.integer "logo_width"
    t.integer "logo_height"
  end

  create_table "product_accessories", :force => true do |t|
    t.integer "product_id",   :null => false
    t.integer "accessory_id", :null => false
    t.integer "position"
  end

  create_table "product_categories", :force => true do |t|
    t.integer "position",                                         :null => false
    t.string  "category",                         :default => "", :null => false
    t.boolean "active",                                           :null => false
    t.string  "permalink",          :limit => 50
    t.text    "content"
    t.string  "image"
    t.integer "image_width"
    t.integer "image_height"
    t.string  "image_alt",          :limit => 50
    t.string  "short_desc"
    t.boolean "show_subcategories"
  end

  create_table "product_sections", :force => true do |t|
    t.integer "product_subcategory_id"
    t.integer "position"
    t.string  "section"
    t.string  "short_desc"
    t.string  "list_image"
    t.integer "width"
    t.integer "height"
    t.text    "content"
    t.boolean "active"
  end

  create_table "product_subcategories", :force => true do |t|
    t.integer "product_category_id",                               :null => false
    t.integer "position",                                          :null => false
    t.string  "subcategory",                       :default => "", :null => false
    t.boolean "active",                                            :null => false
    t.string  "image"
    t.integer "width"
    t.integer "height"
    t.string  "permalink",           :limit => 50
    t.text    "content"
    t.string  "short_desc"
  end

  create_table "products", :force => true do |t|
    t.integer "position",                                                                        :null => false
    t.string  "product",                                                         :default => "", :null => false
    t.string  "alternate_title"
    t.decimal "price",                             :precision => 8, :scale => 2
    t.text    "content"
    t.string  "large_image",        :limit => 100
    t.integer "large_image_width"
    t.integer "large_image_height"
    t.string  "list_image"
    t.integer "list_image_width"
    t.integer "list_image_height"
    t.string  "short_desc"
    t.string  "dimensions",         :limit => 50
    t.string  "qty_per_pkg",        :limit => 50
    t.boolean "show_cart"
  end

  create_table "section_products", :force => true do |t|
    t.integer "product_section_id", :null => false
    t.integer "product_id",         :null => false
  end

  create_table "subcategory_accessories", :force => true do |t|
    t.integer "product_subcategory_id", :null => false
    t.integer "accessory_id",           :null => false
    t.integer "position"
  end

  create_table "subcategory_products", :force => true do |t|
    t.integer "product_subcategory_id",               :null => false
    t.integer "product_id",                           :null => false
    t.integer "position"
    t.string  "permalink",              :limit => 50
  end

  create_table "users", :force => true do |t|
    t.string   "user_name"
    t.string   "display_name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
