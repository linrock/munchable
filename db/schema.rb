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

ActiveRecord::Schema.define(:version => 0) do

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

  create_table "restaurants", :force => true do |t|
    t.integer  "menu_item_id"
    t.string   "url"
    t.string   "name"
    t.float    "rating"
    t.integer  "review_count"
    t.string   "address"
    t.string   "categories"
    t.float    "x"
    t.float    "y"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string    :login,               :null => false   # optional, you can use email instead, or both
    t.string    :email,               :null => false   # optional, you can use login instead, or both
    t.string    :crypted_password,    :null => false   # optional, see below
    t.string    :password_salt,       :null => false   # optional, but highly recommended
    t.string    :persistence_token,   :null => false   # required
    t.string    :single_access_token, :null => false   # optional, see Authlogic::Session::Params
    t.string    :perishable_token,    :null => false   # optional, see Authlogic::Session::Perishability

    # Magic columns, just like ActiveRecord's created_at and updated_at.
    # These are automatically maintained by Authlogic if they are present.
    t.integer   :login_count,         :null => false, :default => 0
    t.integer   :failed_login_count,  :null => false, :default => 0
    t.datetime  :last_request_at
    t.datetime  :current_login_at
    t.datetime  :last_login_at
    t.string    :current_login_ip
    t.string    :last_login_ip
    
    t.string    "role"
    t.datetime  "created_at"
    t.datetime  "updated_at"
  end
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  
  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end
end
