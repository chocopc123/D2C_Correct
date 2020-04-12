Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/login', to: 'devise/sessions#new'
    post 'users/login', to: 'devise/sessions#create'
  end
  post "shops/create" => "shops#create"
  get "shops/new" => "shops#new"
  get "shops/index" => "shops#index"
  post "shops/index" => "shops#index"
  get "shops/login_form" => "shops#login_form"
  post "shops/login" => "shops#login"
  post "logout" => "shops#logout"
  post "shops/search_genre_reset" => "shops#search_genre_reset"
  get "shops/:id" => "shops#show"
  get "shops/:id/edit" => "shops#edit"
  get "shops/:id/password_reset" => "shops#password_reset"
  post "shops/:id/password_update" => "shops#password_update"
  post "shops/:id/update" => "shops#update"
  post "shops/:id/destroy" => "shops#destroy"
  get "shops/:id/add_genre" => "shops#add_genre"
  post "shops/:id/add_genre" => "shops#add_genre"
  get "shops/:id/remove_genre" => "shops#remove_genre"
  post "shops/:id/genre_destroy" => "shops#genre_destroy"
  post "admins/logout" => "admins#logout"
  post "admins/login" => "admins#login"
  get "admins/login" => "admins#login_form"
  get "overview" => "home#overview"
  get "owner" => "home#owner"
  get "about" => "home#about"
  get "/" => "home#top"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
