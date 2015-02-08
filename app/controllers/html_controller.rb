class HtmlController < ApplicationController
  before_action :get_agencies
  before_action :get_routes
  before_action :get_stops

  def bootstrap_data
    @bootstrap_data ||= {}
  end
  helper_method :bootstrap_data

  def get_agencies
    bootstrap_data[:agencies] = Api511.get_remote_agencies
  end

  def get_routes
    if params[:agency_id]
      bootstrap_data[:routes] = Api511.get_routes_for_agency(params[:agency_id])
    end
  end

  def get_stops
    if params[:agency_id] && params[:route_id]
      bootstrap_data[:stops] = Api511.get_stops_for_agency_and_route(params[:agency_id], params[:route_id], params[:direction])
    end
  end


end
