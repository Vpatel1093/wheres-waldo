Rails.application.routes.draw do
  get 'scores/index'

  root to: 'puzzles#index'

  resources 'puzzles', only: [:show]
end
