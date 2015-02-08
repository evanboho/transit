class Api511::DeparturesController < Api511::Api511Controller
  ROUTE = 'GetNextDeparturesByStopCode.aspx'

  def index
    render json: parse_departures_xml(Nokogiri::XML(open url_to_511))
  end

  private

  def parse_departures_xml(doc)
    to_return = []
    doc.xpath('//DepartureTime').each do |node|
      node_hash = {}
      node_hash[:departure_time] = node.text
      node_hash[:agency] = node.xpath('ancestor::Agency').attribute('Name').value
      node_hash[:stop_name] = node.xpath('ancestor::Stop').attribute('name').value
      node_hash[:stop_code] = node.xpath('ancestor::Stop').attribute('StopCode').value
      node_hash[:route_name] = node.xpath('ancestor::Route').attribute('Name').value
      node_hash[:route_code] = node.xpath('ancestor::Route').attribute('Code').value
      to_return << node_hash
    end
    to_return
  end

  def url_to_511
    url_with_token(ROUTE, "stopcode=#{params[:stop_id]}")
  end

end
