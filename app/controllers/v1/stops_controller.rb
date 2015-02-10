class V1::StopsController < ApplicationController

  def index
    render json: NextBus::Stop.all
  end

  def show
    render json: NextBus::Stop.find(params[:id])
  end

  def near
    if params[:lat] && params[:long]
      ## DONT FORGET TO CHANGE RADIUS
      sql = NextBus::Stop.near([params[:lat], params[:long]], 10).limit(10).to_sql
      results = NextBus::Stop.connection.execute(sql)
      stops = results.values.map do |value|
        Hash[results.fields.zip(value)]
      end
      # stops = NextBus::Stop.near([params[:lat], params[:long]], 10) #.limit(10)
      render json: stops
    else
      render json: { error: "Missing paramters: #{missing_paramters}" }
    end
  end

  private

  def missing_paramters
    [(params[:lat] ? nil : "lat"), (params[:long] ? "" : "long")].compact.join(', ')
  end

end
