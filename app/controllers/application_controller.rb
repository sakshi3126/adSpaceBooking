class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_user
  before_action :authenticate_user!, only: [:edit, :update, :destroy]



  private

  def set_user
    @user = current_user
  end


  def user_not_authorized
    flash[:alert] = "You are not authorized to perform that action."
    redirect_to(request.referrer || root_path)
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || root_path
  end
end
