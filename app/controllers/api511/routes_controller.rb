class Api511::RoutesController < Api511::Api511Controller
  ROUTE = 'GetRoutesForAgency.aspx'

  def index
    render json: Api511.get_routes_for_agency(params[:agency_id])
    # render json: NokoProcessor.get_xml_from_api(url_to_511, '//Route')
  end

  # private

  # def url_to_511
  #   url_with_token(ROUTE, "agencyName=#{params[:agency_id]}")
  # end

end
