require 'rails_helper'

describe Api511::RoutesController do

  it 'gets the correct url' do
    subject.params[:agency_id] = 'BART'
    expected_url = 'http://services.my511.org/Transit2.0/GetRoutesForAgency.aspx?agencyName=BART&token=65a0fa17-c546-4755-a272-52616d81380b'
    expect(subject.send :url_to_511).to eq  expected_url
  end

end
