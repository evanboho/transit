class V1::StopsController < ApplicationController
  def index
    render json: NextBus::Stop.all
  end

  def show
  end
end
