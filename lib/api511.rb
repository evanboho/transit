module Api511
  URL_BASE = 'http://services.my511.org/Transit2.0/'

  def self.get_remote_agencies
    url = url_with_token('GetAgencies.aspx')
    NokoProcessor.get_xml_from_api(url, '//Agency')
  end

  def self.get_routes_for_agency(agency_tag)
    route = 'GetRoutesForAgency.aspx'
    url = url_with_token(route, "agencyName=#{agency_tag}")
    NokoProcessor.get_xml_from_api(url, '//Route')
  end

  def self.url_with_token(route, *url_params)
    url_params << 'token=65a0fa17-c546-4755-a272-52616d81380b'
    (URL_BASE + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end

end
