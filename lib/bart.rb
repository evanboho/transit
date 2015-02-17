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

  def self.get_departures

  end

  def self.get_departures_for_route(route_tag)
    route = 'etd.aspx'
    url_with_token(route, { cmd: 'etd' })
    byebug
  end

  def self.url_with_token(route, url_params={})
    url_params[:key] = SITE_CONFIG[:api_token_bart]
    url_params = url_params.map { |k,v| k.to_s + '=' + v }
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
