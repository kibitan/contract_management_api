class V1::SecureController < ActionController::API
  before_action :authenticate

  def current_user
    @current_user ||= User.authenticate_token(request.headers[:'X-User-Token'])
  end

  private

  def authenticate
    render json: {}, status: :unauthorized and return unless current_user
  end
end
