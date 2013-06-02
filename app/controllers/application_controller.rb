class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def is_current_user? user
    user_id = user.is_a?(User) ? user.id : user
    user_signed_in? && current_user.id == user_id
  end

  helper_method :is_current_user?, :top_contributors

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:username, :email) }
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end

  def track_activity trackable, action = params[:action]
    current_user.activities.create! action: action, trackable: trackable
  end
end
