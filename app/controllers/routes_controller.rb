class RoutesController < HtmlController

  def index
    bootstrap_data[:routes] = Api511.get_routes_for_agency(params[:agency_id])
    render 'static/show'
  end

  def show
    bootstrap_data[:routes] = Api511.get_routes_for_agency(params[:agency_id])
    bootstrap_data[:stops] = Api511.get_stops_for_agency_and_route(params[:agency_id], params[:id])
    render 'static/show'
  end

end
