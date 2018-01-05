require 'rails_helper'

describe 'API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/v1/swagger.json') }
  # @see https://qiita.com/kymmt90/items/26c493e5f751a7e4f946
  # @see http://amcaplan.ninja/blog/2016/12/27/automating-empathy-test-your-documentation-with-swagger-and-apivore/
  let(:path_params) { {} }
  let(:headers) { {} }
  let(:query_params) { {} }
  let(:data_params) { {} }
  let(:params) {
    path_params.merge(
      '_headers' => headers,
      '_query_string' => query_params.to_query,
      '_data' => data_params
    )
  }

  context 'has valid paths', order: :random do
    context '/v1/users' do
      let(:data_params) do
        {
          full_name: full_name,
          email:     email,
          password:  password
        }
      end

      context 'with valid paramers' do
        let(:full_name) { Faker::Name.name }
        let(:email)     { Faker::Internet.email }
        let(:password)  { Faker::Internet.password }

        it { is_expected.to validate(:post, '/users', 201, params) }
      end

      pending 'with empty full_name paramers' do
        let(:full_name) { '' }
        let(:email)     { Faker::Internet.email }
        let(:password)  { Faker::Internet.password }

        # TODO: test error message “Full Name should not be empty”
        it { is_expected.to validate(:post, '/users', 400, params) }
      end

      pending 'with empty email paramers' do
        let(:full_name) { Faker::Name.name }
        let(:email)     { '' }
        let(:password)  { Faker::Internet.password }

        # TODO: test error message “Email should not be empty”
        it { is_expected.to validate(:post, '/users', 400, params) }
      end

      pending 'with empty password paramers' do
        let(:full_name) { Faker::Name.name }
        let(:email)     { Faker::Internet.email }
        let(:password)  { '' }

        # TODO: test error message “Password should not be empty”
        it { is_expected.to validate(:post, '/users', 400, params) }
      end

      pending 'with duplicated email paramers' do
        let(:full_name) { Faker::Name.name }
        let(:email)     { Faker::Internet.email }
        let(:password)  { Faker::Internet.password }

        before { 'call UserFactory here' }

        # TODO: test error message “Email is already taken”
        it { is_expected.to validate(:post, '/users', 409, params) }
      end

    end
  end

  context 'and' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
