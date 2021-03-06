require 'rails_helper'

describe NextBus::AgenciesController, type: :controller do
  before(:all) do
    VCR.use_cassette('next_bus_get_remote_agencies') do
      NextBus.import_remote_agencies
    end
  end

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      json = JSON.parse response.body
      expect(json.length).to eq 64
    end
  end

end
