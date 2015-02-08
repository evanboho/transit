module Api511
  URL_BASE = 'http://services.my511.org/Transit2.0/'

  def self.get_remote_agencies
    url = url_with_token('GetAgencies.aspx')
    NokoProcessor.get_xml_from_api(url, '//Agency')
  end

  def self.get_routes_for_agency(agency_name)
    route = 'GetRoutesForAgency.aspx'
    url = url_with_token(route, "agencyName=#{agency_name}")
    doc = Nokogiri::XML(open url)
    raise doc.children.first.name if doc.children.first.name =~ /(E|e)rror/
    to_return = []
    if doc.xpath('//RouteDirection').length > 0
      doc.xpath('//RouteDirection').each do |node|
        node_hash = {}
        node_hash[:name] = node.xpath('ancestor::Route').attribute('Name').value
        node_hash[:code] = node.xpath('ancestor::Route').attribute('Code').value
        node_hash[:direction_code] = node.attribute('Code').value
        node_hash[:direction_name] = node.attribute('Name').value
        to_return << node_hash
      end
      to_return
    else
      NokoProcessor.get_xml_from_api(url, '//Route | //RouteDirection')
    end
  end

  def self.get_stops_for_agency_and_route(agency_name, route_tag, direction=nil)
    route = 'GetStopsForRoute.aspx'
    route_id = [agency_name, route_tag, direction].compact.join('~')
    url = url_with_token(route, "routeIDF=#{route_id}")
    NokoProcessor.get_xml_from_api(url, '//Stop')
  end

  def self.get_departures_for_stop(stop_id)
    route = 'GetNextDeparturesByStopCode.aspx'
    url = url_with_token(route, "stopcode=#{stop_id}")
    doc = Nokogiri::XML(open url)
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

  def self.url_with_token(route, *url_params)
    url_params << 'token=65a0fa17-c546-4755-a272-52616d81380b'
    (URL_BASE + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end

end
