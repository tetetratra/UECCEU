class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :english_name
      t.string :code
      t.string :grade
      t.string :year_offerd
      t.string :semester_offerd
      t.string :course
      t.string :teaching_method
      t.string :credits
      t.string :category
      t.string :cluster_and_department
      t.string :lecturer
      t.string :office
      t.string :email
      t.string :course_website
      t.string :last_updated
      t.string :update_status
      t.string :topic_and_goals
      t.string :prerequisites
      t.string :recommended_prerequisites_and_preparation
      t.string :course_textbooks_and_materials
      t.string :course_outline_and_weekly_schedule
      t.string :course_content_utilizing_practical_experience
      t.string :preparation_and_review_outside_class
      t.string :evaluation_and_grading
      t.string :office_hours
      t.string :message_for_students
      t.string :other
      t.string :keyword

      t.integer :year # 内部での分類用年度
      t.string :url_name # url用のパス

      t.timestamps
    end
  end
end

=begin
授業科目名
/Course title (Japanese)
英文授業科目名
/Course title (English)
科目番号
/Code
開講年度
/Academic year
開講年次
/Year offered
開講学期
/Semester(s) offered
開講コース・課程
/Faculty offering the course
授業の方法
/Teaching method
単位数
/Credits
科目区分
/Category
開講学科・専攻
/Cluster/Department
担当教員名
/Lecturer(s)
居室
/Office
公開E-Mail
/e-mail
授業関連Webページ
/Course website
更新日
/Last updated
更新状況
/Update status
主題および達成目標
/Topic and goals
前もって履修しておくべき科目
/Prerequisites
前もって履修しておくことが望ましい科目
/Recommended prerequisites and preparation
教科書等
/Course textbooks and materials
授業内容とその進め方
/Course outline and weekly schedule
実務経験を活かした授業内容(実務経験内容も含む)
/Course content utilizing practical experience
授業時間外の学習（予習・復習等）
/Preparation and review outside class
成績評価方法および評価基準（最低達成基準を含む）
/Evaluation and grading
オフィスアワー：授業相談
/Office hours
学生へのメッセージ
/Message for students
その他
/Others
キーワード
/Keyword(s)
=end
