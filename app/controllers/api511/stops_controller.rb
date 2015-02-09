class Api511::StopsController < Api511::Api511Controller

  def index
    render json: Api511.get_stops_for_agency_and_route(params[:agency_id], params[:route_id], params[:direction], params[:reload])
  end

end
