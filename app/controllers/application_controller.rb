class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  protected

  def current_user
    @current_user ||= User.where(public_id: current_user_id).first if current_user_id
  end

  def current_user_id
    @current_user_id ||= session[:user_id].presence
  end
end
