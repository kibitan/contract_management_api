class V1::UsersController < ApplicationController
  # POST /v1/users
  def create
    user_create_service = User::CreateService.new(
      full_name: user_params[:full_name],
      email:     user_params[:email],
      password:  user_params[:password]
    )

    if user_create_service.call
      render status: :created, json: { token: user_create_service.user.token }
    else
      if user_create_service.email_conflict?
        render status: :conflict, json: { error_messages: user_create_service.errors.full_messages }
      else
        render status: :bad_request, json: { error_messages: user_create_service.errors.full_messages }
      end
    end
  end

  private
  def user_params
    params.permit(:full_name, :email, :password)
  end
end
