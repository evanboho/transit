namespace :import do

  task :agencies => :environment do
    NextBus.import_remote_agencies
  end

  task :routes, :agency_tag do |t, args|
    agency_tag = args.agency_tag
    agency = NextBus::Agency.find_by(tag: agency_tag)
    unless agency
      agency_attrs = NextBus.get_agencies.detect { |a| a['tag'] == agency_tag }
      raise "No Agency Found: #{agency_tag}" unless agency_attrs
      agency = NextBus::Agency.create!(agency_attrs)
    end
    routes = NextBus.get_routes_for_agency(agency_tag)
    routes.each do |route_attrs|
      route = agency.routes.find_by(tag: route_attrs['tag'])
      if route
        route.update(route_attrs)
      else
        route.create!(route_attrs)
      end
      puts "Adding stops for: #{route.title}"
      route_config = NextBus.get_stops_for_route(agency.tag, route.tag)
      route_config.each do |stop_attrs|
        stop = route.stops.find_by(tag: stop_attrs['tag'])
        next if stop
        route.stops.create!(stop_attrs)
      end
    end
  end

end
