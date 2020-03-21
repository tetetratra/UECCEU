Rails.application.routes.draw do

  root to: 'courses#index', year: Time.now.year, top_page: true

  get ':year/:url_name', to: 'courses#show', constraints: { year: /\d{4}/, url_name: /[\w]+/ }, as: 'year_courses'

  get ':year', to: 'courses#index', constraints: { year: /\d{4}/ }, as: 'year'

  get '*page', to: 'application#render_404' # ブラウザ経由の他のURLは404

  resources :courses, only: [:index, :show] do
    resources :comments, only: [:create]
  end

end
