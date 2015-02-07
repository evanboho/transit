class V1::RoutesController < V1::V1Controller
  ROUTE = 'GetRoutesForAgency.aspx'

  def index
    render json: get_xml_from_511(url_to_511, '//Route')
  end

  private

  def url_to_511
    url_with_token(ROUTE, "agencyName=#{params[:agency_id]}")
  end

end
