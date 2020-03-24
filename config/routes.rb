Rails.application.routes.draw do

  root to: 'application#top_page'

  resources :years, only: [:index, :show] do
    resources :courses, only: [:index, :show] do
      resources :comments, only: [:create]
    end
  end
end
