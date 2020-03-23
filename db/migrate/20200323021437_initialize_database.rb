class InitializeDatabase < ActiveRecord::Migration[6.0]
  def up
    create_table :courses do |t|
      t.integer :inner_index
      t.integer :year
      t.text :url_name

      t.text :course_title_japanese
      t.text :course_title_english
      t.text :code
      t.text :academic_year
      t.text :year_offerd
      t.text :semester_offerd
      t.text :faculty_offering_the_course
      t.text :teaching_method
      t.text :credits
      t.text :category
      t.text :cluster_and_department
      t.text :lecturer
      t.text :office
      t.text :email
      t.text :course_website
      t.text :last_updated
      t.text :update_status
      t.text :topic_and_goals
      t.text :prerequisites
      t.text :recommended_prerequisites_and_preparation
      t.text :course_textbooks_and_materials
      t.text :course_outline_and_weekly_schedule
      t.text :course_content_utilizing_practical_experience
      t.text :preparation_and_review_outside_class
      t.text :evaluation_and_grading
      t.text :office_hours
      t.text :message_for_students
      t.text :other
      t.text :keyword
      t.text :day_and_period
      t.text :timetable_code

      t.timestamps
    end

    create_table :comments do |t|
      t.references :course, foreign_key: true

      t.text :text
      t.text :contributor

      t.timestamps
    end
  end

  def down
    drop_table :comments
    drop_table :courses
  end
end
