module NextBus
  URL_BASE = 'http://webservices.nextbus.com/service/publicXMLFeed?'

  def self.get_local_agencies
    NextBus::Agency.all
  end

  def self.get_remote_agencies
    NokoProcessor.get_xml_from_api(URL_BASE + 'command=agencyList', '//agency')
  end

  def self.get_routes_for_agency(agency_tag)
    url = URL_BASE + "command=routeList&a=#{agency_tag}".gsub(' ', '%20')
    NokoProcessor.get_xml_from_api(url, '//route')
  end

  def self.get_route_config(agency_tag, route_tag)
    url = URL_BASE + "command=routeConfig&a=#{agency_tag}&r=#{route_tag}".gsub(' ', '%20')
    NokoProcessor.get_xml_from_api(url, '//stop')
  end

end
