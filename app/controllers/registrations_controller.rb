class RegistrationsController < Devise::RegistrationsController

  private

  def sign_up_params
    params.require(:user).permit(:name, :mobile, :gender,:dob, :username, :email,:avatar,:provider, :uid, :password, :password_confirmation )
  end

  def account_update_params
    params.require(:user).permit(:name, :mobile, :gender,:dob, :username, :email, :password, :password_confirmation, :current_password)
  end
end
