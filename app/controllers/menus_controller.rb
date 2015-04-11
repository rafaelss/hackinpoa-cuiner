class MenusController < ApplicationController
  def index
    menus = current_user.menus
    respond_with(menus)
  end

  def create
    menu = current_user.menus.create(allowed_params)
    respond_with(menu)
  end

  protected

  def allowed_params
    params.permit(
      :name, :price, :price_per_person, { tags: [] }, { number_of_people: [] }
    )
  end
end
