# frozen_string_literal: true

# deviseによる新規登録処理
# => /usr/local/bundle/gems/devise-4.8.1/app/controllers/devise/registrations_controller.rb


class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :permitted_parameters_sign_up, only: [:create, :update]
  
  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource/registrations#step1
  def step1

    # 一部ダミーで@user作成
    @user = User.new(step1_params)

    if @user.valid?
      # valid
      # dammyデータを削除
      @user.name = nil;
      @user.like_thing = nil;
      @user.location = nil;

      render '/devise/registrations/step2'
    else
      # invalid
      logger.debug(@user.errors.full_messages)

      render '/devise/registrations/new'
    end

  end

  # POST /resource
  def create
    @user =User.new(sign_up_params)
    @user.save
    yield @user if block_given?
    if @user.persisted?
      if @user.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(User, @user)
        respond_with @user, location: after_sign_up_path_for(@user)
      else
        set_flash_message! :notice, :"signed_up_but_#{@user.inactive_message}"
        expire_data_after_sign_in!
        respond_with @user, location: after_inactive_sign_up_path_for(@user)
      end
    else
      set_minimum_password_length
      render '/devise/registrations/step2'
    end
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  end

  # The path used after sign up.
  def after_sign_up_path_for(resource)
    super(resource)
  end

  # The path used after sign up for inactive accounts.
  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end

  # strong_parameterを追加(emailとpasswordはもともと入ってる)
  def permitted_parameters_sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :like_thing, :location])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :like_thing, :location])
  end

  # Strong Parametes
  def step1_params

    # .validメソッド使用の為、ダミー値を設定。DBには保存しない
    params[:user][:name]       = "dammy"
    params[:user][:like_thing] = "dammy"
    params[:user][:location]   = 1
  
    params.require(:user).permit(:email, :password, :password_confirmation, :name, :like_thing, :location)
  end
end
