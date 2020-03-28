class CoursesController < ApplicationController
  COLUMNS = [ # 全検索で調べるカラム
   'course_title_japanese',
   'course_title_english',
   'topic_and_goals',
   'prerequisites',
   'recommended_prerequisites_and_preparation',
   'course_textbooks_and_materials',
   'course_outline_and_weekly_schedule',
   'course_content_utilizing_practical_experience',
   'preparation_and_review_outside_class',
   'evaluation_and_grading',
   'office_hours',
   'message_for_students',
   'other',
   'keyword'
  ].join(',').freeze

  def index
    @year    = Year.friendly.find(params.require('year_id'))
    @courses = if @query = params.permit(:query)[:query]
                 @year.courses.where("CONCAT(#{COLUMNS}) LIKE ?", '%' + @query + '%')
               else
                 @year.courses
               end
  end

  def show
    url_name, inner_index = params.require('id').split(/-(?=\d+$)/) # 末尾のハイフンで区切る
    year                  = params.require('year_id')
    @year                 = Year.friendly.find(year)
    @course               = @year.courses.find_by(url_name: url_name, inner_index: inner_index)
    @comments             = @course.comments
    @comment              = Comment.new
  end
end
