require 'rails_helper'

describe 'API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/v1/swagger.json') }
  # @see https://qiita.com/kymmt90/items/26c493e5f751a7e4f946
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
      let(:full_name) { Faker::Name.name }
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password }
      let(:data_params) do
        {
          full_name: full_name,
          email: email,
          password: password
        }
      end

      it { is_expected.to validate(:post, '/users', 201, params) }
    end
  end

  context 'and' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
