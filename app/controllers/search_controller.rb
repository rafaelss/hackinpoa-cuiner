class SearchController < ApplicationController
  skip_before_action :authenticate!

  def index
    menus = Menu.search(params[:q])
    respond_with(menus, root: "menus")
  end
end
