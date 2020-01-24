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

ActiveRecord::Schema.define(version: 2019_12_26_095018) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "answer_hints", force: :cascade do |t|
    t.text "hint_message"
    t.text "appreciate_message"
    t.string "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bootcamps", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "academy_image"
    t.string "location"
    t.datetime "start_bootcamp"
    t.datetime "end_bootcamp"
    t.string "bootcamp_duration"
    t.string "minimum_attendace"
    t.datetime "class_duration"
    t.datetime "start_class"
    t.datetime "start_class_time"
    t.datetime "end_class_time"
    t.boolean "bootcamp_type"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "name"
    t.bigint "platform_material_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_chapters_on_deleted_at"
    t.index ["platform_material_id"], name: "index_chapters_on_platform_material_id"
  end

  create_table "configurations", id: false, force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.index ["key"], name: "index_configurations_on_key"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "libraries", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "library_image"
    t.string "library_url"
    t.string "library_type"
    t.string "author"
    t.string "reading_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_libraries_on_user_id"
  end

  create_table "material_answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "material_question_id"
    t.boolean "is_correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "answer_hint_id"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_material_answers_on_deleted_at"
    t.index ["material_question_id"], name: "index_material_answers_on_material_question_id"
  end

  create_table "material_questions", force: :cascade do |t|
    t.string "title"
    t.text "question"
    t.boolean "is_active", default: true
    t.bigint "topic_id"
    t.string "question_image"
    t.string "question_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_material_questions_on_deleted_at"
    t.index ["topic_id"], name: "index_material_questions_on_topic_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "news_image"
    t.string "author"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_news_on_user_id"
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.uuid "resource_owner_id"
    t.integer "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "platform_materials", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "photo"
    t.bigint "platform_id"
    t.bigint "level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_platform_materials_on_deleted_at"
    t.index ["level_id"], name: "index_platform_materials_on_level_id"
    t.index ["platform_id"], name: "index_platform_materials_on_platform_id"
  end

  create_table "platforms", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.string "description"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "regencies", force: :cascade do |t|
    t.string "name"
    t.integer "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "student_answers", force: :cascade do |t|
    t.boolean "is_correct"
    t.integer "student_answer_id"
    t.uuid "student_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "last_success"
    t.integer "topic_id"
    t.integer "question_id"
    t.boolean "question_complete", default: false
    t.boolean "topic_complete", default: false
    t.boolean "chapter_complete", default: false
    t.integer "chapter_id"
    t.index ["deleted_at"], name: "index_student_answers_on_deleted_at"
  end

  create_table "topics", force: :cascade do |t|
    t.string "title"
    t.bigint "chapter_id"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["chapter_id"], name: "index_topics_on_chapter_id"
    t.index ["deleted_at"], name: "index_topics_on_deleted_at"
  end

  create_table "user_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.date "birth_date"
    t.string "fullname"
    t.string "age"
    t.string "city"
    t.string "province"
    t.uuid "user_id"
    t.string "education"
    t.string "occupation"
    t.string "industry"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bootcamp_type"
    t.datetime "deleted_at"
    t.integer "gender"
    t.index ["user_id"], name: "index_user_profiles_on_user_id", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "nickname"
    t.string "email"
    t.integer "role_id"
    t.integer "level_id"
    t.integer "platform_id"
    t.integer "bootcamp_id"
    t.boolean "status"
    t.string "user_story"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "chapters", "platform_materials"
  add_foreign_key "libraries", "users"
  add_foreign_key "material_answers", "material_questions"
  add_foreign_key "material_questions", "topics"
  add_foreign_key "news", "users"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "platform_materials", "levels"
  add_foreign_key "platform_materials", "platforms"
  add_foreign_key "topics", "chapters"
  add_foreign_key "user_profiles", "users"
end
