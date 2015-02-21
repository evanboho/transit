require 'open-uri'
module Bart
  URL_BASE='http://api.bart.gov/api/'

  def self.get_routes(reload=false)
    url = url_with_token('route.aspx', { cmd: 'routes' })
    Rails.cache.fetch url, force: reload do
      doc = Nokogiri::XML(open url)
      doc.xpath('//route').map do |route_node|
        Hash[route_node.children.map { |node| [node.name, node.text] }]
      end
    end
  end

  def self.get_route(route_id, reload=false)
    url = url_with_token('route.aspx', { cmd: 'routeinfo', route: route_id })
    Rails.cache.fetch url, force: reload do
      doc = Nokogiri::XML(open url)
      route_node = doc.xpath('//route[1]')
      to_return = Hash[route_node.children.map { |node| [node.name, node.text] }]
      to_return['config'] = route_node.xpath('//config').children.map do |station_node|
        station_node.text
      end
      to_return
    end
  end

  def self.get_departures_for_stop(station_id, direction=nil, reload=false)
    direction = direction[0].downcase if direction.present?
    url = url_with_token('etd.aspx', { cmd: 'etd', orig: station_id, dir: direction })
    Rails.logger.info url
    doc = Nokogiri::XML(open url)
    doc.xpath('//estimate').map do |est_node|
      node_hash = Hash[est_node.children.map { |child_node|
        [child_node.name, child_node.text]
      }]
      node_hash[:destination] = est_node.xpath('preceding-sibling::destination').first.text
      node_hash[:station_name] = est_node.xpath('ancestor::station/name').text
      node_hash
    end
  end

  def self.get_stations
    url = url_with_token('stn.aspx', { cmd: 'stns'})
    Rails.logger.info url
    Rails.cache.fetch url do
      doc = Nokogiri::XML(open url)
      doc.xpath('//station').map do |station_node|
        Hash[station_node.children.map { |node| [node.name, node.text ]}]
      end
    end
  end

  def self.get_departures_for_route(route_tag)
    route = 'etd.aspx'
    url_with_token(route, { cmd: 'etd' })
    byebug
  end

  def self.url_with_token(route, url_params={})
    url_params[:key] = SITE_CONFIG[:api_token_bart]
    url_params = url_params.map { |k,v|
      k.to_s + '=' + v if v.present?
    }.compact
    (URL_BASE + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end

  def self.routes
    {
      '/bart/routes' => 'get_routes',
      '/bart/routes/\w+' => Proc.new { |env|
        id = env['PATH_INFO']
      }
     }
  end


end
