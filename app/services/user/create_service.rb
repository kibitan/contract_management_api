class User::CreateService
  attr_reader :full_name, :email, :password, :user

  def initialize(full_name:, email:, password:)
    @full_name = full_name
    @email     = email
    @password  = password
    @user      = User.new
  end

  def call
    user.assign_attributes(
      full_name: full_name,
      email:     email,
      password:  password,
      password_confirmation: password
    )
    user.save
    true
  end
end
