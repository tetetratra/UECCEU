class CoursesController < ApplicationController
  def index
    @courses = Course.where(year: params[:year]).includes(:comments)
    @year = params[:year]
    @top_page = params[:top_page]
  end

  def search
    @query = params[:query] || ''
    @year = params[:year]
    columns = [
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
    ].join(',')
    @courses = Course.where("CONCAT(#{columns}) LIKE ?", '%' + @query + '%').includes(:comments)
  end

  def show_list
    @courses = Course.where(year: params[:year], url_name: params[:url_name])
    @year = params[:year]
  end

  def show
    if params[:id]
      @course = Course.find(params[:id])
    else
      if (ind = params[:num].to_i - 1) >= 0
        @course = Course.where(year: params[:year], url_name: params[:url_name])[ind]
      else
        @course = nil
      end
    end

    if @course.nil?
      render template: 'errors/error_404'
    else
      @comments = @course.comments
      @comment  = @course.comments.new
    end
  end

  def not_found
  end
end
