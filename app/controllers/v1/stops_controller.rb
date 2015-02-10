class V1::StopsController < ApplicationController

  def index
    render json: NextBus::Stop.all
  end

  def show
    render json: NextBus::Stop.find(params[:id])
  end

end
