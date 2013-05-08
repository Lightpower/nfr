# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130501091923) do

  create_table "archive_code_strings", :force => true do |t|
    t.string  "data",    :null => false
    t.string  "color"
    t.integer "code_id", :null => false
    t.integer "game_id", :null => false
  end

  create_table "archive_codes", :force => true do |t|
    t.integer "number",                   :null => false
    t.string  "name",                     :null => false
    t.string  "info"
    t.string  "ko",                       :null => false
    t.string  "color"
    t.float   "bonus",   :default => 0.0, :null => false
    t.integer "task_id"
    t.integer "game_id",                  :null => false
  end

  create_table "archive_hints", :force => true do |t|
    t.integer "number",  :null => false
    t.text    "data"
    t.integer "delay"
    t.float   "cost"
    t.integer "task_id"
    t.integer "game_id", :null => false
  end

  create_table "archive_logs", :force => true do |t|
    t.string   "login",       :null => false
    t.string   "data",        :null => false
    t.integer  "result_code", :null => false
    t.integer  "team_id"
    t.integer  "code_id"
    t.integer  "game_id",     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_tasks", :force => true do |t|
    t.integer "number"
    t.string  "name"
    t.text    "preview"
    t.text    "data"
    t.integer "code_quota"
    t.float   "bonus"
    t.integer "duration"
    t.integer "zone_id"
    t.integer "task_id"
    t.integer "code_id"
    t.integer "game_id",    :null => false
  end

  create_table "archive_team_bonus", :force => true do |t|
    t.string  "bonus_type",    :null => false
    t.string  "name",          :null => false
    t.text    "description"
    t.float   "rate"
    t.string  "ko"
    t.integer "amount"
    t.integer "team_bonus_id"
    t.integer "team_id",       :null => false
    t.integer "game_id",       :null => false
  end

  create_table "archive_team_codes", :force => true do |t|
    t.string   "data"
    t.integer  "state"
    t.string   "color"
    t.float    "bonus",         :default => 0.0, :null => false
    t.integer  "team_id",                        :null => false
    t.integer  "code_id",                        :null => false
    t.integer  "zone_id"
    t.integer  "team_bonus_id"
    t.integer  "game_id",                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_team_hints", :force => true do |t|
    t.float    "cost"
    t.integer  "team_id"
    t.integer  "hint_id"
    t.integer  "zone_id"
    t.integer  "game_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "archive_team_zones", :force => true do |t|
    t.integer "team_id"
    t.integer "zone_id"
    t.integer "game_id", :null => false
  end

  create_table "archive_teams", :force => true do |t|
    t.string  "name",             :null => false
    t.string  "alternative_name"
    t.string  "image_url"
    t.integer "team_id"
    t.integer "game_id",          :null => false
  end

  create_table "archive_zones", :force => true do |t|
    t.integer "number",    :null => false
    t.string  "name",      :null => false
    t.string  "image_url"
    t.text    "preview"
    t.integer "code_id"
    t.integer "game_id",   :null => false
  end

  create_table "code_strings", :force => true do |t|
    t.string  "data",    :null => false
    t.string  "color"
    t.integer "code_id", :null => false
    t.integer "game_id", :null => false
  end

  add_index "code_strings", ["code_id"], :name => "index_code_strings_on_code_id"
  add_index "code_strings", ["game_id", "data"], :name => "index_code_strings_on_game_id_and_data", :unique => true
  add_index "code_strings", ["game_id"], :name => "index_code_strings_on_game_id"

  create_table "codes", :force => true do |t|
    t.integer "number",                   :null => false
    t.string  "name",                     :null => false
    t.string  "info"
    t.string  "ko",                       :null => false
    t.string  "color"
    t.float   "bonus",   :default => 0.0, :null => false
    t.integer "task_id"
    t.integer "game_id",                  :null => false
  end

  add_index "codes", ["game_id"], :name => "index_codes_on_game_id"
  add_index "codes", ["ko"], :name => "index_codes_on_ko"
  add_index "codes", ["number"], :name => "index_codes_on_number"

  create_table "game_requests", :force => true do |t|
    t.boolean  "is_accepted", :default => false
    t.integer  "game_id",                        :null => false
    t.integer  "team_id",                        :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "game_requests", ["game_id", "team_id"], :name => "index_game_requests_on_game_id_and_team_id", :unique => true

  create_table "games", :force => true do |t|
    t.integer  "number",                         :null => false
    t.string   "name",                           :null => false
    t.string   "format",                         :null => false
    t.string   "game_type",                      :null => false, :default => "zones"
    t.datetime "start_date",                     :null => false
    t.datetime "finish_date"
    t.integer  "price"
    t.string   "area"
    t.text     "image_html"
    t.text     "preview"
    t.text     "legend"
    t.text     "brief_place"
    t.text     "dopy_list"
    t.boolean  "is_active",   :default => false, :null => false
    t.boolean  "is_archived", :default => false, :null => false
    t.string   "prepare_url"
    t.string   "discuss_url"
  end

  add_index "games", ["format"], :name => "index_games_on_format"
  add_index "games", ["name"], :name => "index_games_on_name", :unique => true
  add_index "games", ["number"], :name => "index_games_on_number", :unique => true
  add_index "games", ["start_date"], :name => "index_games_on_start_date"

  create_table "hints", :force => true do |t|
    t.integer "number",  :null => false
    t.text    "data"
    t.integer "delay"
    t.float   "cost"
    t.integer "task_id", :null => false
    t.integer "game_id", :null => false
  end

  add_index "hints", ["game_id", "number", "task_id"], :name => "index_hints_on_game_id_and_number_and_task_id", :unique => true
  add_index "hints", ["game_id"], :name => "index_hints_on_game_id"
  add_index "hints", ["number"], :name => "index_hints_on_number"
  add_index "hints", ["task_id"], :name => "index_hints_on_task_id"

  create_table "logs", :force => true do |t|
    t.string   "login",       :null => false
    t.string   "data",        :null => false
    t.integer  "result_code", :null => false
    t.integer  "team_id",     :null => false
    t.integer  "code_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "game_id",     :null => false
  end

  add_index "logs", ["game_id"], :name => "index_logs_on_game_id"
  add_index "logs", ["team_id"], :name => "index_logs_on_team_id"

  create_table "tasks", :force => true do |t|
    t.integer "number"
    t.string  "name"
    t.text    "preview"
    t.text    "data"
    t.integer "code_quota"
    t.float   "bonus"
    t.integer "duration"
    t.integer "zone_id"
    t.integer "task_id"
    t.integer "code_id"
    t.integer "game_id",    :null => false
  end

  add_index "tasks", ["game_id"], :name => "index_tasks_on_game_id"
  add_index "tasks", ["task_id"], :name => "index_tasks_on_task_id"
  add_index "tasks", ["zone_id"], :name => "index_tasks_on_zone_id"

  create_table "team_bonus", :force => true do |t|
    t.string  "bonus_type",  :null => false
    t.string  "name",        :null => false
    t.text    "description"
    t.float   "rate"
    t.string  "ko"
    t.integer "amount"
    t.integer "team_id",     :null => false
    t.integer "game_id",     :null => false
  end

  add_index "team_bonus", ["game_id"], :name => "index_team_bonus_on_game_id"
  add_index "team_bonus", ["team_id"], :name => "index_team_bonus_on_team_id"

  create_table "team_bonus_actions", :force => true do |t|
    t.integer  "team_bonus_id"
    t.boolean  "is_ok"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "game_id",       :null => false
  end

  add_index "team_bonus_actions", ["game_id"], :name => "index_team_bonus_actions_on_game_id"
  add_index "team_bonus_actions", ["team_bonus_id"], :name => "index_team_bonus_actions_on_team_bonus_id"

  create_table "team_codes", :force => true do |t|
    t.string   "data"
    t.integer  "state"
    t.string   "color"
    t.float    "bonus",         :default => 0.0, :null => false
    t.integer  "team_id",                        :null => false
    t.integer  "code_id",                        :null => false
    t.integer  "zone_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "team_bonus_id"
    t.integer  "game_id",                        :null => false
  end

  add_index "team_codes", ["code_id"], :name => "index_team_codes_on_code_id"
  add_index "team_codes", ["game_id", "team_id", "code_id"], :name => "index_team_codes_on_game_id_and_team_id_and_code_id", :unique => true
  add_index "team_codes", ["game_id"], :name => "index_team_codes_on_game_id"
  add_index "team_codes", ["team_bonus_id"], :name => "index_team_codes_on_team_bonus_id"
  add_index "team_codes", ["team_id"], :name => "index_team_codes_on_team_id"
  add_index "team_codes", ["zone_id"], :name => "index_team_codes_on_zone_id"

  create_table "team_hints", :force => true do |t|
    t.float    "cost",       :default => 0.0, :null => false
    t.integer  "team_id"
    t.integer  "hint_id"
    t.integer  "zone_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "game_id",                     :null => false
  end

  add_index "team_hints", ["game_id"], :name => "index_team_hints_on_game_id"
  add_index "team_hints", ["hint_id"], :name => "index_team_hints_on_hint_id"
  add_index "team_hints", ["team_id"], :name => "index_team_hints_on_team_id"
  add_index "team_hints", ["zone_id"], :name => "index_team_hints_on_zone_id"

  create_table "team_requests", :force => true do |t|
    t.boolean "by_user"
    t.integer "team_id"
    t.integer "user_id"
  end

  add_index "team_requests", ["by_user"], :name => "index_team_requests_on_by_user"
  add_index "team_requests", ["team_id", "user_id"], :name => "index_team_requests_on_team_id_and_user_id", :unique => true
  add_index "team_requests", ["team_id"], :name => "index_team_requests_on_team_id"
  add_index "team_requests", ["user_id"], :name => "index_team_requests_on_user_id"

  create_table "team_zones", :force => true do |t|
    t.integer "team_id"
    t.integer "zone_id"
    t.integer "game_id", :null => false
  end

  add_index "team_zones", ["game_id", "team_id", "zone_id"], :name => "index_team_zones_on_game_id_and_team_id_and_zone_id", :unique => true
  add_index "team_zones", ["game_id"], :name => "index_team_zones_on_game_id"

  create_table "teams", :force => true do |t|
    t.string  "name",             :null => false
    t.string  "alternative_name"
    t.string  "image_url"
    t.integer "user_id",          :null => false
  end

  add_index "teams", ["name"], :name => "index_teams_on_name"
  add_index "teams", ["user_id"], :name => "index_teams_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "team_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "username"
    t.string   "role"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role"], :name => "index_users_on_role"
  add_index "users", ["team_id"], :name => "index_users_on_team_id"
  add_index "users", ["username"], :name => "index_users_on_username"

  create_table "zone_holders", :force => true do |t|
    t.float    "amount",       :null => false
    t.integer  "zone_id",      :null => false
    t.integer  "team_id",      :null => false
    t.integer  "team_code_id"
    t.datetime "time"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "game_id",      :null => false
  end

  add_index "zone_holders", ["game_id"], :name => "index_zone_holders_on_game_id"
  add_index "zone_holders", ["team_code_id"], :name => "index_zone_holders_on_team_code_id"
  add_index "zone_holders", ["team_id"], :name => "index_zone_holders_on_team_id"
  add_index "zone_holders", ["zone_id"], :name => "index_zone_holders_on_zone_id"

  create_table "zones", :force => true do |t|
    t.integer "number",    :null => false
    t.string  "name",      :null => false
    t.string  "image_url"
    t.text    "preview"
    t.integer "code_id"
    t.integer "game_id",   :null => false
  end

  add_index "zones", ["game_id", "name"], :name => "index_zones_on_game_id_and_name", :unique => true
  add_index "zones", ["game_id", "number"], :name => "index_zones_on_game_id_and_number", :unique => true
  add_index "zones", ["game_id"], :name => "index_zones_on_game_id"

end
