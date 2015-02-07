require 'open-uri'
class V1::V1Controller < ApplicationController
  URL = 'http://services.my511.org/Transit2.0/'

  def get_xml_from_511(url, xpath)
    doc = Nokogiri::XML(open url)
    nodes = doc.xpath(xpath)
    nodes.map do |node|
      attrs = node.attributes.map do |k,v|
        [k, v.value]
      end
      Hash[attrs]
    end
  end

  def url_with_token(route, *url_params)
    url_params << 'token=65a0fa17-c546-4755-a272-52616d81380b'
    (URL + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end
end
