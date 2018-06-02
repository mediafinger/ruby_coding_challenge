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

ActiveRecord::Schema.define(version: 2018_05_31_221700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "challenges", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "rating_aggregator_id"
    t.text "description"
    t.datetime "open_from"
    t.datetime "open_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rating_aggregator_id"], name: "index_challenges_on_rating_aggregator_id"
  end

  create_table "contestants", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "solution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solution_id"], name: "index_contestants_on_solution_id"
    t.index ["user_id", "solution_id"], name: "index_contestants_on_user_id_and_solution_id", unique: true
    t.index ["user_id"], name: "index_contestants_on_user_id"
  end

  create_table "creations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id", "user_id"], name: "index_creations_on_challenge_id_and_user_id", unique: true
    t.index ["challenge_id"], name: "index_creations_on_challenge_id"
    t.index ["user_id"], name: "index_creations_on_user_id"
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

  create_table "rating_aggregators", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.text "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rating_aggregators_on_user_id"
  end

  create_table "rating_methods", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.text "code"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_rating_methods_on_user_id"
  end

  create_table "requirements", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id"
    t.uuid "spec_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["spec_id"], name: "index_requirements_on_spec_id"
    t.index ["task_id", "spec_id"], name: "index_requirements_on_task_id_and_spec_id", unique: true
    t.index ["task_id"], name: "index_requirements_on_task_id"
  end

  create_table "solutions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "task_id"
    t.text "code"
    t.integer "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_solutions_on_task_id"
  end

  create_table "specs", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.text "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_specs_on_user_id"
  end

  create_table "tasks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "challenge_id"
    t.uuid "rating_method_id"
    t.text "description"
    t.datetime "open_from"
    t.datetime "open_until"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_tasks_on_challenge_id"
    t.index ["rating_method_id"], name: "index_tasks_on_rating_method_id"
    t.index ["user_id"], name: "index_tasks_on_user_id"
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
