class AgenciesController < HtmlController

  def index
    render 'static/show'
  end

  def show
    bootstrap_data[:routes] = Api511.get_routes_for_agency(params[:id])
    render 'static/show'
  end

end
