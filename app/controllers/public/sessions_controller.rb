# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :user_state, only: [:create]

  def after_sign_in_path_for(resource)
    flash[:notice] = 'Signed in successfully.'
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to games_path, notice: 'Signed in successfully.'
  end

  def guest_sign_out
    user = User.guest
    sign_out user
    redirect_to new_user_registration_path
  end

  protected

  def user_state
    # 入力されたemailからアカウントを1件取得
    user = User.find_by(email: params[:user][:email])
    # アカウントを取得できなかった場合、このメソッドを終了
    return if user.nil?
    # 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別
    # user.statusがfalseだったときに遷移させる
    if user.valid_password?(params[:user][:password]) && !user.is_active
      flash[:notice] = "This account has been deleted."
      redirect_to new_user_registration_path
    end
  end

end
