class Api511::AgenciesController < Api511::Api511Controller
  ROUTE = 'GetAgencies.aspx'

  def index
    render json: NokoProcessor.get_xml_from_api(url_to_511, '//Agency')
  end

  private

  def url_to_511
    url_with_token(ROUTE)
  end

end
