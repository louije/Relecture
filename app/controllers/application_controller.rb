class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :services_list

  def services_list
    @services = [:instapaper, :pinboard]
  end

  def not_found
    raise ActiveRecord::RecordNotFound.new('404 / Not Found')
  end

end
