class ReadController < ApplicationController
	before_action :gather_links
	include ApplicationHelper

  def jump
  	redirect_to root_path if @links.blank?
  	redirect_to @links.sample.url
  end

  def explore
  end

  private

  	def gather_links
  		@authorized_services = @services.map { |s| load_service(s) }.compact
  		if !@authorized_services.blank?
  		  @random 	 = @authorized_services.map { |s| s.random(5) }.flatten.sample(5)
  		  @years_ago = @authorized_services.map { |s| s.years_ago }.flatten
  		end
  		@links = [*@random] + @years_ago
  	end
end
