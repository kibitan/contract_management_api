require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.save with has_secure_password' do
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

      it 'will fail' do
        is_expected.to be false

        expect(user.persisted?).to be false
      end
    end

    context 'password_confirmation is match with password' do
      let(:password_confirmation) { password }

      it 'save with encrypted password' do
        is_expected.to be true
        expect(user.persisted?).to be true

        expect(user.full_name).to eq full_name
        expect(user.email).to     eq email
        expect(user.password_digest).not_to eq password
        expect(user.authenticate(password)).to eq user
        expect(user.authenticate(password + 'fake')).to be false
      end
    end
  end
end
