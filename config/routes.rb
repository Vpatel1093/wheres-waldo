Rails.application.routes.draw do
  root to: 'puzzles#index'
  resources 'puzzles', only: [:show]
  resources 'scores', only: [:index, :create]
end
