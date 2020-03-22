class CommentsController < ApplicationController
  def create
    params.permit! # アクセスできないのを許可
    comment = Comment.new(text: params[:comment][:text], course_id: params[:course_id], contributor: params[:comment][:contributor])
    course = Course.find(params[:course_id])
    if comment.save
      redirect_to "/#{course.year}/#{course.url_name}/#{course.inner_index}#comment_form", notice: 'コメントしました'
    else
      if params[:comment][:text].strip.empty?
        redirect_to "/#{course.year}/#{course.url_name}/#{course.inner_index}#comment_form", notice: '空文字のコメントは出来ません'
      else
        redirect_to "/#{course.year}/#{course.url_name}/#{course.inner_index}#comment_form", notice: 'コメント処理時にエラーが起きました'
      end
    end
  end
end

