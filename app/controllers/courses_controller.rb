class CoursesController < ApplicationController

  MAIN_COLUMNS = [
    :comment_sort,
    :curriculum,
    :course_title_japanese,
    :course_title_english,
    :day_and_period,
    :timetable_code,
    :year_offerd,
    :semester_offerd,
    :faculty_offering_the_course,
    :credits,
    :category,
    :cluster_and_department,
    :lecturer,
    :query,
    :url_name
  ]

  SUB_COLUMNS = [ # 全検索で調べるカラム
   :course_title_japanese,
   :course_title_english,
   :topic_and_goals,
   :prerequisites,
   :recommended_prerequisites_and_preparation,
   :course_textbooks_and_materials,
   :course_outline_and_weekly_schedule,
   :course_content_utilizing_practical_experience,
   :preparation_and_review_outside_class,
   :evaluation_and_grading,
   :office_hours,
   :message_for_students,
   :other,
   :keyword
  ]

  def index
    @year       = Year.friendly.find(params.require(:year_id))
    @courses    = @year.courses.page(params[:page]).per(100)
    @pre_params = {}
  end

  def search
    params.permit!
    @year    = Year.friendly.find(params.require(:year_id))
    @courses = @year.courses.then{ |courses|
      params[:url_name].blank? ? courses : courses.where('url_name LIKE ?', params[:url_name] + '%')
    }.then { |courses|
      (MAIN_COLUMNS - [:curriculum, :credits, :comment_sort, :query, :url_name]).inject(courses) do |cou, col|
        params[col].blank? ? cou : cou.where("#{col} REGEXP ?", params[col])
      end
    }.then { |courses|
      if params[:curriculum].blank?
        courses
      else
        courses.where("curriculum LIKE ?", params[:curriculum] + '%')
      end
    }.then { |courses|
      n, o = *params[:credits]&.chars
      if n.blank?
        courses
      elsif o.nil?
        courses.where(credits: n)
      else
        courses.where('credits >= ?', n)
      end
    }.then { |courses|
      case params[:comment_sort]
      when 'desc' then courses.order('comment_count DESC')
      when 'new'  then courses.order('updated_at DESC')
      else             courses
      end
    }.then { |courses|
      if params[:query].blank?
        courses
      else
        params[:query].split(/[[:space:]]/).inject(courses) do |c, q|
          c.where("CONCAT(#{SUB_COLUMNS.join(',')}) LIKE ?", '%' + q + '%')
        end
      end
    }.page(params[:page]).per(100)
    @pre_params = MAIN_COLUMNS.map do |col|
      { col => params[col] }
    end.inject(:merge)
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
