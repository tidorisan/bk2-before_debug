class ApplicationController < ActionController::Base
  # deviseのストロングパラメータ
	before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後のページ変遷の設定
  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  def after_sign_out_path_for(resource)
    root_path
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
