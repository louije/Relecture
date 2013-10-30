class ServicesController < ApplicationController
  before_action :load_service_from_session, only: [:show]

  include ApplicationHelper
  include ServicesHelper

  def index
    @authorized_services = @services.map { |s| load_service(s) }.compact
    if !@authorized_services.blank?
      @random = @authorized_services.sample.random
      @years_ago = @authorized_services.sample.years_ago
    end
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
      redirect_to service_path(params[:service]), notice: "Successfully logged into #{@service.name}."
    else
      session[symbol] = nil
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
    name = service_class.new.name
    session[symbol] = nil
    redirect_to root_path, notice: "Successfully logged out of #{name}"
  end

  private

    def load_service_from_session
      # s = session[symbol]
      # if s
      #   @service = load_service(params[:service], s)
      # end
      @service = load_service
    end

end
