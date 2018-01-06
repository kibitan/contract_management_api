require 'rails_helper'

describe User::CreateService do
  describe '#call' do
    subject { user_create_service.call }

    let(:user_create_service) do
      User::CreateService.new(
        full_name: full_name,
        email:     email,
        password:  password
      )
    end

    context 'with valid arguments' do
      let(:full_name) { Faker::Name.name }
      let(:email)     { Faker::Internet.email }
      let(:password)  { Faker::Internet.password }

      it 'create user', :aggregate_failures do
        expect{ subject }.to change(User, :count).by(1)
        is_expected.to be true
        expect(user_create_service.user).to eq User.last
      end

      context 'duplicated email' do
        before do
          User::CreateService.new(
            full_name: full_name,
            email:     email,
            password:  password
          ).call
        end

        it 'not create user', :aggregate_failures do
          expect{ subject }.not_to change(User, :count)
          is_expected.to be false
          expect(user_create_service.errors.details[:email]).to include error: :taken
        end
      end
    end

    context 'with invalid arguments' do
      context 'empty full_name' do
        let(:full_name) { '' }
        let(:email)     { Faker::Internet.email }
        let(:password)  { Faker::Internet.password }

        it 'not create user', :aggregate_failures do
          expect{ subject }.not_to change(User, :count)
          is_expected.to be false
          expect(user_create_service.errors.details[:full_name]).to include error: :blank
        end
      end

      context 'invalid full_name format' do
        pending
      end

      context 'empty email' do
        let(:full_name) { Faker::Name.name }
        let(:email)     { '' }
        let(:password)  { Faker::Internet.password }

        it 'not create user', :aggregate_failures do
          expect{ subject }.not_to change(User, :count)
          is_expected.to be false
          expect(user_create_service.errors.details[:email]).to include error: :blank
        end
      end

      context 'invalid email format' do
        pending
      end

      context 'empty password' do
        context 'empty email' do
          let(:full_name) { Faker::Name.name }
          let(:email)     { Faker::Internet.email }
          let(:password)  { '' }

          it 'not create user', :aggregate_failures do
            expect{ subject }.not_to change(User, :count)
            is_expected.to be false
            expect(user_create_service.errors.details[:password]).to include error: :blank
          end
        end
      end

      context 'invalid password format' do
        pending
      end
    end
  end
end
