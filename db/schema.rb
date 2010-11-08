# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101108075929) do

  create_table "categories", :force => true do |t|
    t.string "name"
  end
  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.integer  "list_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  create_table "friendships", :force => true do |t|
    t.integer "user_id"
    t.integer "friend_id"
  end

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "listings", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "list_id"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "city"
    t.string   "state"
    t.integer  "zoom_level"
    t.float    "x_center"
    t.float    "y_center"
    t.float    "x_lower"
    t.float    "x_upper"
    t.float    "y_lower"
    t.float    "y_upper"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "locations", ["city", "state"], :name => "index_locations_on_city_state", :unique => true

  create_table "memberships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_comments", :force => true do |t|
    t.integer  "restaurant_id"
    t.integer  "menu_item_id"
    t.integer  "parent_id"
    t.text     "content"
    t.integer  "karma"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "menu_items", :force => true do |t|
    t.integer "restaurant_id"
    t.string  "name"
    t.string  "description"
    t.string  "price"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restaurants", :force => true do |t|
    t.integer  "location_id"
    t.string   "url"
    t.string   "name"
    t.float    "rating"
    t.integer  "review_count"
    t.string   "hours"
    t.string   "address"
    t.string   "categories"
    t.string   "website"
    t.string   "good_for"
    t.boolean  "delivery"
    t.boolean  "take_out"
    t.float    "x"
    t.float    "y"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.point    "xy",           :limit => nil, :null => false, :srid => 4326
  end
  add_index "restaurants", ["x", "y"], :name => "index_restaurants_on_x_y", :unique => true
  add_index "restaurants", ["xy"], :name => "index_restaurants_on_xy", :spatial => true
  execute "CREATE INDEX restaurants_name_idx ON restaurants USING gin(to_tsvector('english', name))"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
end
