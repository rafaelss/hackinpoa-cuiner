class UsersController < ApplicationController
  respond_to :json

  def create
    user = User.create(params.permit(:name, :email, :password, :password_confirmation))
    respond_with(user)
  end

  def show
    user = User.where(public_id: params[:id]).first!
    respond_with(user)
  end
end
