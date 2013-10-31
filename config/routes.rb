Relecture::Application.routes.draw do
  root to: 'services#index'

  get      '/explore',            to: 'read#explore'
  get      '/reread',             to: 'read#jump'
  match    '/log_out',            to: 'services#log_out_all',  as: 'log_out_services',  via: [:get, :delete]

  scope :services do
    post   '/:service/auth',      to: 'services#auth',         as: 'auth_service'
    get    '/:service/log_in',    to: 'services#log_in',       as: 'log_in_service'
    get    '/:service/log_out',   to: 'services#log_out',      as: 'log_out_service'
    match  '/:service',           to: 'services#show',         as: 'service',           via: [:get, :post]          
  end

end
