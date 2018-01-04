class V1::UsersController < ApplicationController
  # POST /v1/users
  def create
    render status: :created, json: {auth_token: 'token12345' }
  end

  private
  def user_params
    params.fetch(:v1_user, {})
  end
end
