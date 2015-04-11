class MenusController < ApplicationController
  def index
    menus = current_user.menus
    respond_with(menus)
  end

  def create
    menu = current_user.menus.create(params.permit(
      :name, :price, :price_per_person, :number_of_people
    ))

    respond_with(menu)
  end
end
