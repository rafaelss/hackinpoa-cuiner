class SearchController < ApplicationController
  skip_before_action :authenticate!

  def index
    filters = []
    filters << "price<=#{params[:price]}" if params[:price].to_f > 0
    filters << "max_number_of_people>=#{params[:persons]}" if params[:persons].to_i > 0

    args = [params[:q]]
    if filters.present?
      args << { numericFilters: filters }
    end

    menus = Menu.search(*args)
    respond_with(menus, root: "menus")
  end
end
