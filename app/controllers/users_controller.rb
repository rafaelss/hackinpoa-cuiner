class UsersController < ApplicationController
  respond_to :json

  def create
    user = User.create(params.permit(:name, :email, :password, :password_confirmation))
    respond_with(user)
  end

  def show
    if current_user
      respond_with(current_user)
    else
      respond_with({ error: "not logged in" }, status: 403)
    end
  end

  def authenticate
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.public_id
      redirect_to user_path
    else
      respond_with({ error: "not logged in" }, status: 403)
    end
  end
end
