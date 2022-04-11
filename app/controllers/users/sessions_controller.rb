# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
   before_action :reject_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  protected
  
  #会員の論理削除。退会後は同アカウント不可
  
  def reject_user
    @user = User.find_by(name: params[:user][:name])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
        flash[:notice] ='退会済みです。再度登録をして下さい'　
        redirect_to new_user_registration_path
      else
        flash[:notice] = '項目を入力してください。'
      end
    end  
end
