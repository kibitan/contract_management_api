class User::CreateService
  attr_reader :full_name, :email, :password

  def initialize(full_name:, email:, password:)
    @full_name = full_name
    @email     = email
    @password  = password
  end

  def call
    true
  end

  def user
    Struct.new(:full_name, :email, :persisted?)
          .new(full_name, email, true)
  end
end
