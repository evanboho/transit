class NextBus::AgenciesController < NextBus::NextBusController
  URL = 'http://webservices.nextbus.com/service/publicXMLFeed?command=agencyList'

  def index
    render json: get_xml_from_api(URL, '//agency')
  end

end

