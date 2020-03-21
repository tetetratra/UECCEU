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

ActiveRecord::Schema.define(version: 2020_03_21_035417) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id"
    t.index ["course_id"], name: "index_comments_on_course_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "english_name"
    t.string "code"
    t.string "academic_year"
    t.string "year_offerd"
    t.string "semester_offerd"
    t.string "faculty_offering_the_course"
    t.string "teaching_method"
    t.string "credits"
    t.string "category"
    t.string "cluster_and_department"
    t.string "lecturer"
    t.string "office"
    t.string "email"
    t.string "course_website"
    t.string "last_updated"
    t.string "update_status"
    t.text "topic_and_goals"
    t.text "prerequisites"
    t.text "recommended_prerequisites_and_preparation"
    t.text "course_textbooks_and_materials"
    t.text "course_outline_and_weekly_schedule"
    t.text "course_content_utilizing_practical_experience"
    t.text "preparation_and_review_outside_class"
    t.text "evaluation_and_grading"
    t.text "office_hours"
    t.text "message_for_students"
    t.text "other"
    t.text "keyword"
    t.integer "year"
    t.string "url_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lectures", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "year"
    t.string "term"
    t.string "academic_year"
    t.string "faculty_offering_the_course"
    t.string "dayofweek"
    t.string "code"
    t.string "category"
    t.string "course_title_japanese"
    t.string "teacher"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "course_title_english"
    t.string "year_offerd"
    t.string "semester_offerd"
    t.string "teaching_method"
    t.string "credits"
  end

  add_foreign_key "comments", "courses"
end
