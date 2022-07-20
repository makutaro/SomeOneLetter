Rails.application.routes.draw do

   # deviseで使用するroute定義
  # ここに定義しないrouteはgemに定義されたctrlが参照される
  # ココ => /usr/local/bundle/gems/devise-4.8.1/lib/devise
  # あくまでカスタマイズしたいrouteのみを記述すること

  devise_for :users, controllers: {
    confirmations:       'users/confirmations',     # 
    passwords:           'users/passwords',         # passを忘れた場合
    registrations:       'users/registrations',     # ユーザの新規登録
    sessions:            'users/sessions',          # ユーザのログイン
    unlocks:             'users/unlocks'
  }


  # 静的ページ(home,about,contact)
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # letterモデルを使用
  resources :letters, only: [:new,:create]
   # GET   /letters/new    new
   # POST  /letters        create
end