class ApplicationController < ActionController::Base
  def top_page
    @comments = Comment.all.order(created_at: 'DESC').limit(30)
    render template: 'top_page', layout: 'application', content_type: 'text/html'
  end

  def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  end

  def crawl
    if CrawlHistory.all.empty? || CrawlHistory.last.created_at < Time.now.ago(1.day)
      CrawlHistory.create
      CampusCrawler::Handler.start_crawling(params[:year]&.to_i)
      return render plain: 'クロール完了'
    end
    render plain: 'クロール実行済み'
  end
end
