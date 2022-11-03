Rails.application.routes.draw do
  get 'search' => 'searches#search'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users
  root to: "homes#top"

  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
     resource :favorites, only: [:create, :destroy]#上のdoと一緒にいいねで追加
     resources :book_comments, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update,:create]do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end#フォロアーフォロー追加

  resources :chats, only: [:show, :create] #DM

 get "home/about"=>"homes#about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
