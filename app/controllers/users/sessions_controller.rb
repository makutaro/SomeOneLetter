# frozen_string_literal: true
# 呼び出し先 => /usr/local/bundle/gems/devise-4.8.1/app/controllers/devise/sessions_controller.rb

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in_with_modal(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end

private

def sign_in_with_modal(resource_name, resource)
  flash[:flag] = :hello_modal_open if sign_in(resource_name, resource)
end