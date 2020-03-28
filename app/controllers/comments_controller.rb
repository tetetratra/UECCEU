class CommentsController < ApplicationController
  def create
    year_id               = params.require(:year_id)
    url_name, inner_index = params.require(:course_id).split(/-(?=\d+$)/)
    contributor           = params.require(:comment).require(:contributor)
    text                  = params.require(:comment).require(:text)
    @year   = Year.friendly.find(year_id)
    @course = @year.courses.find_by(url_name: url_name, inner_index: inner_index)
    @course.update(
      comment_count: @course.comment_count + 1
    )
    @course.comments.create(
      contributor: contributor,
      text: text
    )
    redirect_to [@year, @course]
  end
end
