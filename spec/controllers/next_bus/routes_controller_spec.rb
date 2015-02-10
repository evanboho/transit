require 'rails_helper'

describe NextBus::RoutesController, :type => :controller do
  before(:all) do
    VCR.use_cassette('next_bus_get_remote_agencies') do
      NextBus.import_remote_agencies
    end
    VCR.use_cassette('next_bus_get_routes_for_sf_muni') do
      NextBus.import_routes_for_agency('sf-muni')
    end
  end

  describe "GET index" do
    it "returns http success" do
      VCR.use_cassette('next_bus_routes_index_sf_muni') do
        get :index, agency_id: 'sf-muni'
        json = JSON.parse(response.body)
        expect(json.length).to eq 82
      end
    end
  end

end
