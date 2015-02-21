class Bart::DeparturesController < ApplicationController

  def index
    render json: Bart.get_departures_for_stop(params[:stop_id], params[:direction], params[:reload])
  end

end
