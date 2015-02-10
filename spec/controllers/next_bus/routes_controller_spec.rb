require 'rails_helper'

RSpec.describe NextBus::RoutesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      VCR.use_cassette('next_bus_routes_index_bart') do
        get :index, agency_id: 'BART'
        expect(response).to have_http_status(:success)
      end
    end
  end

end
