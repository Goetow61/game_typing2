Rails.application.routes.draw do
  root to: 'questions#index'
  resources :questions do
    get 'play'
  end
end
