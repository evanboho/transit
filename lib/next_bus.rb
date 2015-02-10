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

  def self.import_routes_for_agency(agency_tag)
    agency = NextBus::Agency.find_by(tag: agency_tag)
    unless agency
      agency_attrs = NextBus.get_remote_agencies(true).detect { |a| a['tag'] == agency_tag }
      raise "No Agency Found: #{agency_tag}" unless agency_attrs
      agency = NextBus::Agency.create!(agency_attrs)
    end
    routes = NextBus.get_routes_for_agency(agency_tag, true)
    routes.each do |route_attrs|
      import_route_for_agency(agency, route_attrs)
    end
  end

  def self.import_route_for_agency(agency, route_attrs)
    route = agency.routes.find_by(tag: route_attrs['tag'])
    if route
      route.update(route_attrs)
    else
      route = agency.routes.create!(route_attrs)
    end
    puts "Adding stops for: #{route.title}, #{route.tag}"
    route_config = NextBus.get_stops_for_route(agency.tag, route.tag)
    route_config.each do |stop_attrs|
      import_stop_for_route(route, stop_attrs)
    end
  end

  def self.import_stop_for_route(route, stop_attrs)
    stop = route.stops.find_by(tag: stop_attrs['tag'])
    return if stop
    route.stops.create!(stop_attrs)
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
