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

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.save with has_secure_password, has_secure_token' do
    let(:user) { User.new }
    let(:full_name) { Faker::Name.name }
    let(:email)     { Faker::Internet.email }
    let(:password)  { Faker::Internet.password }

    subject do
      user.assign_attributes(
        full_name: full_name,
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )
      user.save
    end

    context 'password_confirmation is not match with password' do
      let(:password_confirmation) { password + 'hoge' }

      it 'fail to save' do
        is_expected.to be false

        expect(user.persisted?).to be false
      end
    end

    context 'password_confirmation is match with password' do
      let(:password_confirmation) { password }

      it 'save with encrypted password and token' do
        is_expected.to be true
        expect(user.persisted?).to be true

        expect(user.full_name).to eq full_name
        expect(user.email).to     eq email
        expect(user.password_digest).not_to eq password
        expect(user.token).not_to be_empty

        expect(user.authenticate(password)).to eq user
        expect(user.authenticate(password + 'fake')).to be false
      end
    end

    describe '.authenticate_token' do
      subject { User.authenticate_token(token) }
      let!(:user) do
        ucs = User::CreateService.new(
          full_name: Faker::Name.name,
          email:     Faker::Internet.email,
          password:  Faker::Internet.password
        )
        ucs.call
        ucs.user
      end

      context 'with valid token' do
        let(:token) { user.token }

        it { is_expected.to eq user }
      end

      context 'with invalid token' do
        let(:token) { user.token + 'fake' }

        it { is_expected.to be false }
      end
    end
  end
end
