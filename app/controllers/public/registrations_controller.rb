# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]
  # before_action :guest_not_destroy, only: [:destroy]

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end


  # protected

  # def guest_not_destroy
  #   if resource.email == 'guest@guest.com'
  #     redirect_to root_path, alert: 'ゲストは削除できません。'
  #   end
  # end

end
