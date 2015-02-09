class Api511::RoutesController < Api511::Api511Controller
  ROUTE = 'GetRoutesForAgency.aspx'

  def index
    render json: Api511.get_routes_for_agency(params[:agency_id], params[:reload])
  end

end
