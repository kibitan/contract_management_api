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
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  # @see http://guides.rubyonrails.org/active_model_basics.html#securepassword
  has_secure_password

  with_options presence: true do |required_column|
    required_column.validates :full_name
    required_column.validates :email, uniqueness: true
    required_column.validates :password_digest
  end
end
