class User < ApplicationRecord
  # @see http://guides.rubyonrails.org/active_model_basics.html#securepassword
  has_secure_password

  with_options presence: true do |required_column|
    required_column.validates :full_name
    required_column.validates :email, uniqueness: true
    required_column.validates :password_digest
  end
end
