require 'rails_helper'

describe NextBus do

  it 'imports agencies' do
    NextBus::Agency.destroy_all
    VCR.use_cassette('next_bus_get_remote_agencies') do
      expect {
        NextBus.import_remote_agencies
      }.to change(NextBus::Agency, :count).by 64
    end
  end

  it 'imports routes for agencies' do
    VCR.use_cassette('next_bus_get_remote_agencies') do
      NextBus.import_remote_agencies
    end
    VCR.use_cassette('next_bus_get_route_for_sf_muni') do
      route_attrs = NextBus.get_routes_for_agency('sf-muni')
      agency = NextBus::Agency.find_by(tag: 'sf-muni')
      expect {
        route_attrs.first(2).each do |attrs|
          NextBus.import_route_for_agency(agency, attrs)
        end
      }.to change(NextBus::Route, :count).by 2
    end
  end
end
