  # deviseで使用するroute定義
  # ここに定義しないrouteはgemに定義されたctrlが参照される
  # ココ => /usr/local/bundle/gems/devise-4.8.1/lib/devise
  # あくまでカスタマイズしたいrouteのみを記述すること

  # ※メモ
  # GET   /users        index
  # GET   /users/1      show
  # GET   /users        new
  # POST  /users        create
  # GET   /users/1/edit edit
  # PATCH /users/1      update
  # DELETE /users/1     destory

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
    root 'static_pages#top'
    get  '/home',   to: 'static_pages#home'
    get  '/about',   to: 'static_pages#about'
    get  '/contact', to: 'static_pages#contact'


  #userモデル(edit,inbox)
  resources :users do
    member do
      get :match_room # GET  /users/[user_id]/match_room/[match_room_id]
    end
  end

  # letterモデル
  resources :letters, only: [:new,:create,:destroy,:show] do
                    # GET   /letters/[user_id]    index
                    # GET   /letters/new          new
                    # POST  /letters              create
                    # DELETE /letters/[letter_id] destroy
    member do
      post :release # POST  /letters/[letter_id]/release
      post :reply   # POST   /letters/[to_user_id]/reply
    end
  end

  # inbox_recordsモデル
  resources :inbox_records, only:[:show,:destroy] do
    collection do
      get :room
    end
  end

end

