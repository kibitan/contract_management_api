class V1::CurrentUsersController < V1::SecureController
  def show
    render json: {
      user_id:   current_user.id.to_s,
      full_name: current_user.full_name,
      email:     current_user.email
    }
  end
end
