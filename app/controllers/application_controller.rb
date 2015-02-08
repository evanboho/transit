class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def bootstrap_data
    @bootstrap_data ||= {}
  end
  helper_method :bootstrap_data


end
