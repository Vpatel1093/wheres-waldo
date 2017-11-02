Rails.application.routes.draw do
  root to: 'puzzles#index'
  get 'scores/index'
  resources 'puzzles', only: [:show]
end
