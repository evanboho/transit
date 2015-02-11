class V1::RoutesController < ApplicationController

  def index
    render json: NextBus::Route.all
  end

end
