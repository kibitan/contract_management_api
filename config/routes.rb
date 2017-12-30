Rails.application.routes.draw do
  namespace :v1 do
    resource :swagger, only: :show, constraints: ->(req) { req.format == :json }
  end
end
