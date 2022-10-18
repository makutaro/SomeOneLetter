Rails.application.routes.draw do

    #devise関連
    devise_for :users, controllers: {
      confirmations:       'users/confirmations',     # 
      passwords:           'users/passwords',         # passを忘れた場合
      registrations:       'users/registrations',     # ユーザの新規登録
      sessions:            'users/sessions',          # ユーザのログイン
      unlocks:             'users/unlocks'
    }
    devise_scope :user do
      post 'new_user_step1', to: 'users/registrations#step1'
    end

  # 静的ページ(home,about,contact)
    root 'main_pages#top'
    get  '/home',    to: 'main_pages#home'

  # letterモデル
  resources :letters, only: [:create,:destroy]
  
  # inbox_recordsモデル
  resources :inbox_records, only:[:index,:destroy] do
    collection do
      post :release
    end
  end
  
  # roomモデル
  resources :match_rooms, only:[:show]
end
  # ※メモ
  # GET   /users        index
  # GET   /users/1      show
  # GET   /users        new
  # POST  /users        create
  # GET   /users/1/edit edit
  # PATCH /users/1      update
  # DELETE /users/1     destory

