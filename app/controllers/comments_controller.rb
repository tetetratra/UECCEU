class CommentsController < ApplicationController
  def create
    params.permit! # アクセスできないのを許可
    comment = Comment.new(text: params[:comment][:text], course_id: params[:course_id])
    course = Course.find(params[:course_id])
    if comment.save
      redirect_to "/#{course.year}/#{course.url_name}#comment_form", notice: 'コメントしました'
    else
      redirect_to "/#{course.year}/#{course.url_name}#comment_form", notice: 'コメント処理時にエラーが起きました'
    end
  end
end

