module NextBus
  URL_BASE = 'http://webservices.nextbus.com/service/publicXMLFeed?'

  def self.get_local_agencies
    NextBus::Agency.all
  end

  def self.import_remote_agencies
    get_remote_agencies(true).each do |agency_attrs|
      NextBus::Agency.find_by(tag: agency_attrs['tag']) ||
      NextBus::Agency.create!(agency_attrs)
    end
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

  def self.get_departures_for_stop(agency_tag, stop_id)
    url = URL_BASE + "command=predictions&a=#{agency_tag}&stopId=#{stop_id}"
    NokoProcessor.get_xml_from_api(url, '//prediction')
  end

end
