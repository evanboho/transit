class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def get_xml_from_api(url, xpath)
    doc = Nokogiri::XML(open url)
    nodes = doc.xpath(xpath)
    nodes.map do |node|
      attrs = node.attributes.map do |k,v|
        [k, v.value]
      end
      Hash[attrs]
    end
  end

end
