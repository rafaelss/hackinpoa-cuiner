class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :authenticate!
  respond_to :json

  Unauthorized = Class.new(StandardError)
  rescue_from Unauthorized do
    respond_with({ error: "not authorized" }, status: 403, location: nil)
  end

  protected

  def authenticate!
    unauthorized! unless current_user
  end

  def unauthorized!
    raise Unauthorized
  end

  def current_user
    @current_user ||= User.where(public_id: current_user_id).first if current_user_id
  end

  def current_user_id
    @current_user_id ||= session[:user_id].presence
  end
end
