class Api511::Api511Controller < ApplicationController
  URL = 'http://services.my511.org/Transit2.0/'

  def url_with_token(route, *url_params)
    url_params << 'token=65a0fa17-c546-4755-a272-52616d81380b'
    (URL + route + '?' + url_params.join('&')).gsub(' ', '%20')
  end
end
