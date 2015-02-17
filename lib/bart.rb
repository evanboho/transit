require 'open-uri'
module Bart
  URL_BASE='http://api.bart.gov/api/'

  def self.get_routes

  end

  def self.get_departures

  end

  def self.get_departures_for_route(route_tag)
    route = 'etd.aspx'
    url_with_token(route, { cmd: 'etd' })
    byebug
  end

  def self.url_with_token(route, url_params={})
    url_params[:token] = SITE_CONFIG[:api_token_bart]
    url_params = url_params.map { |k,v| k.to_s + '=' + v }
    (URL_BASE + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end


end
