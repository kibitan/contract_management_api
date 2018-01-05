require 'rails_helper'

describe User::CreateService do
  describe '#call' do
    subject do
      User::CreateService.new(
        full_name: full_name,
        email:     email,
        password:  password
      ).tap(&:call)
    end

    context 'with valid arguments' do
      let(:full_name) { Faker::Name.name }
      let(:email)     { Faker::Internet.email }
      let(:password)  { Faker::Internet.password }

      it 'create user', :aggregate_failures do
        expect{ subject }.to change(User, :count).by(1)
        expect{ subject }.not_to raise_error
        expect(subject.user).to eq User.last
      end
    end

    pending 'with invalid arguments' do
      context 'empty full_name' do
      end
      context 'invalid full_name format' do
      end
      context 'empty email' do
      end
      context 'invalid email format' do
      end
      context 'empty password' do
      end
      context 'invalid password format' do
      end
    end
  end
end
