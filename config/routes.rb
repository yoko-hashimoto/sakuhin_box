Rails.application.routes.draw do

  root 'tops#index'

  devise_for :users, controllers: {
    # registrations_controller.rbで記述する内容を有効にする
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :tops, only: [:index]

  resources :creators do
    # クリエイターの詳細画面から、そのクリエイターに紐付いた作品一覧画面に遷移する為、入れ子でルーティングを設定
    resources :artworks, only: [:index]
    # Ajaxで呼ばれてフォルダの一覧を返すアクション
    resources :folders
  end

  resources :artworks

  resources :users, :only => [:update, :show, :edit, :destroy]

  resources :folders do 
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
