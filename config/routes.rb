Rails.application.routes.draw do
  get '/signup' => 'users#new'
  post '/users' => 'users#create'
  root 'puzzles#index'
  get '/answer' => 'puzzles#answer'
  get '/puzzles' => 'puzzles#index'
  get 'puzzles/new' => "puzzles#new"
  get 'puzzles/:id' => 'puzzles#show', as: :puzzle
  post '/puzzles' => 'puzzles#create'
  get 'puzzles/:id/edit' => 'puzzles#edit', as: :edit_puzzle
  patch 'puzzles/:id' => 'puzzles#update'
  delete 'puzzles/:id' => 'puzzles#destroy', as: :puzzle_destroy
  get "/login" => "sessions#new"
  post "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"
end
