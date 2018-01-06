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
    return false if user_invalid?
    user.save
  end

  def email_conflict?
    errors.details[:email].include?(error: :taken)
  end

  private

  def user_invalid?
    user.assign_attributes(
      full_name: full_name,
      email:     email,
      password:  password,
      password_confirmation: password
    )
    user.validate

    user.errors.details.each do |attribute, attribute_errors|
      attribute_errors.each do |detail, _value|
        errors.add(attribute, detail[:error])
      end
    end

    user.invalid?
  end
end
