require 'open-uri'
class NokoProcessor

  def self.get_xml_from_api(url, xpath)
    Rails.logger.info url
    doc = Nokogiri::XML(open url)
    raise doc.children.first.name if doc.children.first.name =~ /(E|e)rror/
    nodes = doc.xpath(xpath)
    nodes.map do |node|
      attrs = node.attributes.map do |k,v|
        [k.underscore, v.value]
      end
      Hash[attrs]
    end
  end

end
