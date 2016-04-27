require 'open-uri'
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
    agency = agency_tag.is_a?(NextBus::Agency) ? agency_tag : NextBus::Agency.find_by(tag: agency_tag)
    agency_tag = agency.tag
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
    doc = Nokogiri::XML(open url)
    raise doc.children.first.name if doc.children.first.name =~ /(E|e)rror/
    Rails.logger.info url
    doc.xpath('//prediction').map do |node|
      attrs = node.attributes.map do |k,v|
        [k.underscore, v.value]
      end
      node_hash = Hash[attrs]
      node_hash[:direction] = node.xpath('ancestor::direction').attribute('title').value
      predictions_node = node.xpath('ancestor::predictions')
      node_hash[:agency_name] = predictions_node.attribute('agencyTitle').value
      node_hash[:route_name] = predictions_node.attribute('routeTitle').value
      node_hash[:route_tag] = predictions_node.attribute('routeTag').value
      node_hash[:stop_title] = predictions_node.attribute('stopTitle').value
      node_hash[:stop_tag] = predictions_node.attribute('stopTag').value
      node_hash
    end
  end

end
