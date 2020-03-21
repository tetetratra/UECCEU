class CoursesController < ApplicationController
  def index
    @courses = Course.where(year: params[:year])
    @year = params[:year]
    @top_page = params[:top_page]
  end

  def show
    if params[:id]
      @course = Course.find(params[:id])
    else
      @course = Course.find_by(year: params[:year], url_name: params[:url_name])
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
