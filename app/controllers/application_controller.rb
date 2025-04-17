class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  
  before_action :authenticate_admin_user
  
  private
  
  def authenticate_admin_user
    unless admin_user_signed_in?
      redirect_to admin_login_path, alert: "Please log in to access this page."
    end
  end
  
  def current_admin_user
    @current_admin_user ||= AdminUser.find_by(id: session[:admin_user_id]) if session[:admin_user_id]
  end
  helper_method :current_admin_user
  
  def admin_user_signed_in?
    current_admin_user.present?
  end
  helper_method :admin_user_signed_in?
end
