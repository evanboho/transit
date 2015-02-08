class NextBus::AgenciesController < NextBus::NextBusController

  def index
    render json: NextBus.get_agencies
  end

end

