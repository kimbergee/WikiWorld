class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :require_sign_in, except: [:index, :show]
  # before_action :authorize_user, except: [:index, :show]

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    wikis_path
  end

  def authenticate_user!(options={})
    if user_signed_in?
      super(options)
    else
      redirect_to(request.referrer || root_path)
      flash[:alert] = "Sorry, you need to be logged in to do that."
    end
  end

  private

  # def require_sign_in
  #   unless current_user
  #     flash[:error] = "You must be logged in to do that"
  #     redirect_to new_user_session_path
  #   end
  # end

  def user_not_authorized
    flash[:alert] = "Sorry, you are not allowed to do that."
    redirect_to(request.referrer || root_path)
  end
end
