class StaticController < ApplicationController

  def show
    @agencies = Api511.get_remote_agencies
  end

end
