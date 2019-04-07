Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root 'artworks#index'

  resources :creators do
    # クリエイターの詳細画面から、そのクリエイターに紐付いた作品一覧画面に遷移する為、入れ子でルーティングを設定
    resources :artworks
  end

  resources :artworks

  resources :users, :only => [:update, :show, :edit, :destroy]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
