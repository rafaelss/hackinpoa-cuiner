class UsersController < ApplicationController
  skip_before_action :authenticate!, only: [:authenticate]

  def create
    user = User.create(allowed_params)
    respond_with(user)
  end

  def show
    user = User.where(public_id: params[:id]).first!
    respond_with(user)
  end

  def authenticate
    user = User.where(email: params[:email]).first
    unauthorized! unless user && user.authenticate(params[:password])

    session[:user_id] = user.public_id
    redirect_to current_user_url
  end

  protected

  def allowed_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
