class V1::StopsController < V1::V1Controller
  ROUTE = 'GetStopsForRoute.aspx'

  def index
    render json: get_xml_from_511(url_to_511, '//Stop')
  end

  private

  def url_to_511
    url_with_token(ROUTE, "routeIDF=#{params[:agency_id]}~#{params[:route_id]}")
  end

end
