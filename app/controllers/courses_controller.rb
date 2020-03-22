class CoursesController < ApplicationController
  def index
    @courses = Course.where(year: params[:year])
    @year = params[:year]
    @top_page = params[:top_page]
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
