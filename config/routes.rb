Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"


  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
     resource :favorites, only: [:create, :destroy]#上のdoと一緒にいいねで追加
  end
  resources :users, only: [:index,:show,:edit,:update,:create]

 get "home/about"=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
