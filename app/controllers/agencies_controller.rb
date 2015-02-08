class AgenciesController < ApplicationController
  before_action :get_agencies

  def index
    render 'static/show'
  end

  def show
    bootstrap_data[:agency] = Api511.get_routes_for_agency(params[:id])
    render 'static/show'
  end

  private

  def get_agencies
    bootstrap_data[:agencies] = Api511.get_remote_agencies
  end

end
