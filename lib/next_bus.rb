module NextBus
  URL_BASE = 'http://webservices.nextbus.com/service/publicXMLFeed?'

  def self.get_local_agencies
    NextBus::Agency.all
  end

  def self.get_remote_agencies(reload_cache=false)
    url = URL_BASE + 'command=agencyList'
    Rails.cache.fetch url, force: reload_cache do
      NokoProcessor.get_xml_from_api(url, '//agency')
    end
  end

  def self.get_routes_for_agency(agency_tag, reload_cache=false)
    url = URL_BASE + "command=routeList&a=#{agency_tag}".gsub(' ', '%20')
    Rails.cache.fetch url, force: reload_cache do
      NokoProcessor.get_xml_from_api(url, '//route')
    end
  end

  def self.get_stops_for_route(agency_tag, route_tag, reload_cache=false)
    url = URL_BASE + "command=routeConfig&a=#{agency_tag}&r=#{route_tag}".gsub(' ', '%20')
    Rails.cache.fetch url, force: reload_cache do
      NokoProcessor.get_xml_from_api(url, '//stop')
    end
  end

end
