class NextBus::DeparturesController < NextBus::NextBusController

  def index
    render json: NextBus.get_departures_for_stop(params[:agency_id], params[:stop_id])
  end

end
