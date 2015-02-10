require 'rails_helper'

describe AgenciesController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      VCR.use_cassette('511_agencies_index') do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

end
