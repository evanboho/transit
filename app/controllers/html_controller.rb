class HtmlController < ApplicationController
  before_action :get_agencies

  def bootstrap_data
    @bootstrap_data ||= {}
  end
  helper_method :bootstrap_data

  def get_agencies
    bootstrap_data[:agencies] = Api511.get_remote_agencies
  end


end
