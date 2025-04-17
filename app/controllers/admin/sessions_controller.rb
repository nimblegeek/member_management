class Admin::SessionsController < ApplicationController
  layout 'admin_auth'
  skip_before_action :authenticate_admin_user, only: [:new, :create]
  
  def new
    redirect_to admin_root_path if admin_user_signed_in?
  end
  
  def create
    admin_user = AdminUser.find_by(email: params[:email].downcase)
    
    if admin_user&.authenticate(params[:password])
      session[:admin_user_id] = admin_user.id
      admin_user.update_last_login
      redirect_to admin_root_path, notice: "Welcome back, #{admin_user.name}!"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session[:admin_user_id] = nil
    redirect_to admin_login_path, notice: "You have been logged out."
  end
end 