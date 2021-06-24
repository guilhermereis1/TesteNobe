class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_account, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :cpf_or_cnpj, :email, :password, :password_confirmation)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:password, :password_confirmation)}
  end

  def after_sign_out_path_for(resource_or_scope)
    dashboard_user_home_index_path
  end

  def set_account
    @account = Account.find_by(user_id: current_user.id)
  end
end
