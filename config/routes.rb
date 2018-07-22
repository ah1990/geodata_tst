Rails.application.routes.draw do

  root to: 'base#index'

  # Intercept routes by React. Should always in bottom list of possible routes
  get '*path', to: 'base#index'

end
