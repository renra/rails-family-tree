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

ActiveRecord::Schema.define(:version => 20121112103728) do

  create_table "people", :force => true do |t|
    t.string   "name"
    t.string   "gender"
    t.text     "description"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.date     "orientation_date"
    t.string   "place_of_birth"
    t.string   "burial_place"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "relations", :force => true do |t|
    t.integer  "originating_person_id"
    t.integer  "target_person_id"
    t.string   "relation_type"
    t.boolean  "adopted",               :default => false
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  add_index "relations", ["originating_person_id"], :name => "index_relations_on_originating_person_id"
  add_index "relations", ["target_person_id"], :name => "index_relations_on_target_person_id"

  create_table "users", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
