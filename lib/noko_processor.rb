require 'open-uri'
class NokoProcessor

  def self.get_xml_from_api(url, xpath)
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
