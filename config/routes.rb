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

  #userモデル(edit,inbox)
  resources :users, only: [:edit] do
    member do
      get :inbox  # GET  /users/[user_id]/inbox
    end
  end

  # 静的ページ(home,about,contact)
  root 'static_pages#home'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # letterモデルを使用
  resources :letters, only: [:new,:create]
   # GET   /letters/[user_id]        index
   # GET   /letters/new    new
   # POST  /letters        create
  end

# ※メモ
# GET   /users        index
# GET   /users/1      show
# GET   /users        new
# POST  /users        create
# GET   /users/1/edit edit
# PATCH /users/1      update
# DELETE /users/1     destory