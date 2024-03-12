Rails.application.routes.draw do
  root "tops#index"
  resources :users
  resources :musics do
    collection {get "search"}
  end
end
