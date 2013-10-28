class ServicesController < ApplicationController
  before_action :load_service_from_session, only: [:show]

  include ServicesHelper

  def index
    @services = [:instapaper, :pinboard]
  end

  def log_in
    @service = service_class.new
    begin
      render "services/#{@service.label}/log_in"
    rescue ActionView::MissingTemplate
      render "log_in"
    end
  end

  def auth
    s = session[symbol]
    @service = service_class.new(params[:auth] || s)
    if @service.authorized?
      session[symbol] = @service.token 
      redirect_to service_path(params[:service]), notice: "Successfully logged in to #{@service.name}."
    else
      redirect_to log_in_service_path(params[:service]), alert: "Authorization failed."
    end
  end

  def show
    if @service
      @bookmarks = @service.bookmarks(params[:list_options])
      @random = @service.random
      @years_ago = @service.years_ago
    else
      redirect_to log_in_service_path(params[:service]), notice: "Please log in."
    end
  end

  def log_out
    session[symbol] = nil
  end

  private

    def symbol
      "#{params[:service]}_token".to_sym
    end

    def load_service_from_session
      s = session[symbol]
      if s
        attempt = service_class.new(s)
        @service = attempt if attempt.authorized?
      end
    end

    def service_class
      begin
        (params[:service].to_s.titleize+"Service").constantize
      rescue NameError
        not_found
      end
    end

end
