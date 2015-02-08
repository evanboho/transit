class Api511::StopsController < Api511::Api511Controller

  def index
    render json: Api511.get_stops_for_agency_and_route(params[:agency_id], params[:route_id], params[:direction])
  end

  private

  def url_to_511
    url_with_token(ROUTE, "routeIDF=#{params[:agency_id]}~#{params[:route_id]}")
  end

end
