class DeparturesController < HtmlController

  def index
    # bootstrap_data[:stops] = Api511.get_stops_for_agency_and_route(params[:agency_id], params[:route_id], params[:direction])
    render 'static/show'
  end

end
