class DeleteCoursesColumns < ActiveRecord::Migration[6.0]
  def change
    # 不要カラム
    # remove_column :courses, :grade, :string
    # remove_column :courses, :course, :string

    # 足りなかったカラム
    # add_column    :courses, :academic_year, :string
    # add_column    :courses, :faculty_offering_the_course, :string

    # 型変更
    change_column :courses, :topic_and_goals, :text
    change_column :courses, :prerequisites, :text
    change_column :courses, :recommended_prerequisites_and_preparation, :text
    change_column :courses, :course_textbooks_and_materials, :text
    change_column :courses, :course_outline_and_weekly_schedule, :text
    change_column :courses, :course_content_utilizing_practical_experience, :text
    change_column :courses, :preparation_and_review_outside_class, :text
    change_column :courses, :evaluation_and_grading, :text
    change_column :courses, :office_hours, :text
    change_column :courses, :message_for_students, :text
    change_column :courses, :other, :text
    change_column :courses, :keyword, :text
  end
end
