class User::CreateService
  include ActiveModel::Validations
  attr_reader :full_name, :email, :password, :user

  with_options presence: true do |required_column|
    required_column.validates :full_name
    required_column.validates :email
    required_column.validates :password
  end

  def initialize(full_name:, email:, password:)
    @full_name = full_name
    @email     = email
    @password  = password
    @user      = User.new
  end

  def call
    return false if invalid?

    user.assign_attributes(
      full_name: full_name,
      email:     email,
      password:  password,
      password_confirmation: password
    )
    user.save
  end
end
