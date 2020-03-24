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

ActiveRecord::Schema.define(version: 2020_03_24_063942) do

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.bigint "course_id"
    t.text "text"
    t.text "contributor"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_comments_on_course_id"
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "inner_index"
    t.integer "year"
    t.text "url_name"
    t.text "course_title_japanese"
    t.text "course_title_english"
    t.text "code"
    t.text "academic_year"
    t.text "year_offerd"
    t.text "semester_offerd"
    t.text "faculty_offering_the_course"
    t.text "teaching_method"
    t.text "credits"
    t.text "category"
    t.text "cluster_and_department"
    t.text "lecturer"
    t.text "office"
    t.text "email"
    t.text "course_website"
    t.text "last_updated"
    t.text "update_status"
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
    t.text "day_and_period"
    t.text "timetable_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "year_id"
    t.index ["year_id"], name: "index_courses_on_year_id"
  end

  create_table "years", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "comments", "courses"
  add_foreign_key "courses", "years"
end
