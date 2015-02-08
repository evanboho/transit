class NextBus::RoutesController < ApplicationController

  def index
    render json: NextBus.get_routes_for_agency(params[:agency_id])
  end

  def show
    render json: NextBus.get_route_config(params[:agency_id], params[:id])
  end

end
