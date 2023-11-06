class ApplicationController < ActionController::Base
	# before_action :authenticate_user!, except: [:top, :about]
	before_action :configure_permitted_parameters, if: :devise_controller?

	def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(Admin)
      games_path
    else
      root_path
    end
  end

	def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      root_path
    end
  end



	protected

	def configure_permitted_parameters
		if resource_class == User
      devise_parameter_sanitizer.permit(:sign_up,
      keys: [:nickname, :introduction, :email, :password, :password_confirmation])

      devise_parameter_sanitizer.permit(:account_update,
      keys: [:nickname, :introduction, :email, :password, :password_confirmation])

			devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
		end
	end

end
