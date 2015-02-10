class NextBus::StopsController < NextBus::NextBusController

  def index
    render json: NextBus.get_stops_for_route(params[:agency_id], params[:route_id])
  end

end
