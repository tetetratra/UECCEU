class ApplicationController < ActionController::Base
  def top_page
    @comments = Comment.all.order(created_at: 'DESC').limit(30)
    render template: 'top_page', layout: 'application', content_type: 'text/html'
  end

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end
end
