class V1::AgenciesController < V1::V1Controller
  ROUTE = 'GetAgencies.aspx'

  def index
    render json: get_xml_from_511(url_to_511, '//Agency')
  end

  private

  def url_to_511
    url_with_token(ROUTE)
  end

end
