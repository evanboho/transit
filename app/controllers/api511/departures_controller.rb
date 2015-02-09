class Api511::DeparturesController < Api511::Api511Controller

  def index
    render json: Api511.get_departures_for_stop(params[:stop_id], params[:reload])
  end

end
