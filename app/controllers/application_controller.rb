class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception, prepend: true
	before_action :configure_permitted_parameters, if: :devise_controller? 

  	protected

	  	def configure_permitted_parameters
		    added_attrs = [:name, :avtar,:username,:mobile , :email, :password, :password_confirmation, :remember_me]
		    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
		    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	 	end


	def after_sign_in_path_for(users)
		stored_location_for(users) || welcome_index_path
	end

	
end
