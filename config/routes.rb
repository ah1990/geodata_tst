Rails.application.routes.draw do

  root to: 'base#index'

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :buildings, only: :index
    end
  end

  # Intercept routes by React. Should always in bottom list of possible routes
  get '*path', to: 'base#index'

end
