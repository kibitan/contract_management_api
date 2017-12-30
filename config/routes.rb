Rails.application.routes.draw do
  namespace :v1 do
    resource :swagger, only: :show
  end
end
