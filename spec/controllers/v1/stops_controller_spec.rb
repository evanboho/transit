require 'rails_helper'

RSpec.describe V1::StopsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, id: 1
      expect(response).to have_http_status(:success)
      expect(response.body).to eq NextBus::Stop.find(1).to_json
    end
  end

end
