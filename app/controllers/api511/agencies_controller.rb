class Api511::AgenciesController < Api511::Api511Controller

  def index
    render json: Api511.get_remote_agencies(params[:reload])
  end

end
