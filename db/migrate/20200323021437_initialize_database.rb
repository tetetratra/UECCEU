class InitializeDatabase < ActiveRecord::Migration[6.0]
  def up
    sql=<<SQL
-- Create syntax for TABLE 'courses'
CREATE TABLE `courses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `inner_index` int(11) DEFAULT NULL,
  `course_title_japanese` text,
  `course_title_english` text,
  `code` text,
  `academic_year` text,
  `year_offerd` text,
  `semester_offerd` text,
  `faculty_offering_the_course` text,
  `teaching_method` text,
  `credits` text,
  `category` text,
  `cluster_and_department` text,
  `lecturer` text,
  `office` text,
  `email` text,
  `course_website` text,
  `last_updated` text,
  `update_status` text,
  `topic_and_goals` text,
  `prerequisites` text,
  `recommended_prerequisites_and_preparation` text,
  `course_textbooks_and_materials` text,
  `course_outline_and_weekly_schedule` text,
  `course_content_utilizing_practical_experience` text,
  `preparation_and_review_outside_class` text,
  `evaluation_and_grading` text,
  `office_hours` text,
  `message_for_students` text,
  `other` text,
  `keyword` text,
  `year` int(11) DEFAULT NULL,
  `url_name` text,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `day_and_period` text,
  `timetable_code` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
SQL
    sql2=<<SQL
-- Create syntax for TABLE 'comments'
CREATE TABLE `comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `text` text,
  `contributor` text,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `course_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_comments_on_course_id` (`course_id`),
  CONSTRAINT `fk_rails_d0f578074a` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
SQL
    ActiveRecord::Base.connection.execute(sql)
    ActiveRecord::Base.connection.execute(sql2)
  end

  def down
    drop_table :comments
    drop_table :courses
  end
end
