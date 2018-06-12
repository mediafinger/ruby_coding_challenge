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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_12_222200) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "challengers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_challengers_on_task_id"
    t.index ["user_id", "task_id"], name: "index_challengers_on_user_id_and_task_id", unique: true
    t.index ["user_id"], name: "index_challengers_on_user_id"
  end

  create_table "challenges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "competition_id"
    t.uuid "task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id", "task_id"], name: "index_challenges_on_competition_id_and_task_id", unique: true
    t.index ["competition_id"], name: "index_challenges_on_competition_id"
    t.index ["task_id"], name: "index_challenges_on_task_id"
  end

  create_table "competitions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.text "rating_method"
    t.datetime "open_from"
    t.datetime "open_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contestants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "solution_id"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solution_id"], name: "index_contestants_on_solution_id"
    t.index ["user_id", "solution_id"], name: "index_contestants_on_user_id_and_solution_id", unique: true
    t.index ["user_id"], name: "index_contestants_on_user_id"
  end

  create_table "invitations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "creator_id"
    t.uuid "invitee_id"
    t.string "entity_type"
    t.uuid "entity_id"
    t.boolean "answer"
    t.string "description"
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_invitations_on_creator_id"
    t.index ["entity_type", "entity_id"], name: "index_invitations_on_entity_type_and_entity_id"
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
  end

  create_table "organizers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "competition_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id", "user_id"], name: "index_organizers_on_competition_id_and_user_id", unique: true
    t.index ["competition_id"], name: "index_organizers_on_competition_id"
    t.index ["user_id"], name: "index_organizers_on_user_id"
  end

  create_table "solutions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "competition_id"
    t.uuid "task_id"
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["competition_id", "task_id"], name: "index_solutions_on_competition_id_and_task_id", unique: true
    t.index ["competition_id"], name: "index_solutions_on_competition_id"
    t.index ["task_id"], name: "index_solutions_on_task_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "description"
    t.text "spec"
    t.datetime "open_from"
    t.datetime "open_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "nick"
    t.string "image"
    t.string "url"
    t.string "provider"
    t.string "provider_uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "roles", default: [], array: true
    t.index ["provider", "provider_uid"], name: "index_users_on_provider_and_provider_uid", unique: true
    t.index ["roles"], name: "index_users_on_roles", using: :gin
  end

end
