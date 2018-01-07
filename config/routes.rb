Rails.application.routes.draw do
  namespace :v1 do
    resource :swagger, only: :show, constraints: ->(req) { req.format == :json }
    resources :users, only: :create
    resource :current_user, only: :show
  end
end
