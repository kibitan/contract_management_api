# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  full_name       :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  token           :string           not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#  index_users_on_token  (token) UNIQUE
#

class User < ApplicationRecord
  # @see http://guides.rubyonrails.org/active_model_basics.html#securepassword
  has_secure_password
  has_secure_token

  with_options presence: true do |required_column|
    required_column.validates :full_name
    required_column.validates :email, uniqueness: true
    required_column.validates :password_digest
    # NOTE: validate for token will not work correctly and no need
    # required_column.validates :token, uniqueness: true
  end

  class << self
    def authenticate_token(token)
      find_by(token: token) || false
    end
  end
end
