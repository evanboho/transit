class NextBus::RoutesController < ApplicationController

  def index
    render json: NextBus.get_routes_for_agency(params[:agency_id], params[:reload])
  end

end
