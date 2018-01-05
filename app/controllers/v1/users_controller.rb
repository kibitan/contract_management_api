class V1::UsersController < ApplicationController
  # POST /v1/users
  def create
    user_token =
      User::CreateService.new(user_params.to_h.symbolize_keys).tap do |ucs|
        ucs.call
        break ucs.user.token
      end

    render status: :created, json: {token: user_token}
  end

  private
  def user_params
    params.permit(:full_name, :email, :password)
  end
end
