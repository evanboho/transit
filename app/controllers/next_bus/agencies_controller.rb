class NextBus::AgenciesController < NextBus::NextBusController

  def index
    render json: NextBus.get_local_agencies
  end

end

