module ApplicationHelper

  def load_service(service = nil, attributes = nil)
    service ||= params[:service] if params
    attributes ||= session[symbol(service)] || {}
    attempt = service_class(service).new(attributes.dup) # the Pinboard gem deletes the :token key, so we need a dup
    return attempt if attempt.authorized?
  end

  def service_class service = nil
  	service ||= params[:service] if params and params[:service]
    begin
      (service.to_s.titleize+"Service").constantize
    rescue NameError
      not_found
    end
  end

	def service_authorized? service
		return s.authorized? if s = load_service(service)
	end

  def symbol service = nil
    "#{service || params[:service]}_token".to_sym
  end


end
