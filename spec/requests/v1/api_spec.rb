require 'rails_helper'

# @see http://amcaplan.ninja/blog/2016/12/27/automating-empathy-test-your-documentation-with-swagger-and-apivore/
current_dir = File.dirname(File.expand_path(__FILE__))
Dir[current_dir + '/api/*.rb'].each do |file|
  require file
end

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
    it_behaves_like "users endpoint"
  end

  context 'and' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
