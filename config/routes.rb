Rails.application.routes.draw do
  namespace :v1 do
    resource :swagger, only: :show, constraints: ->(req) { req.format == :json }
    resources :users, only: :create
  end

  mount SwaggerUiEngine::Engine, at: "/api_docs"
end
