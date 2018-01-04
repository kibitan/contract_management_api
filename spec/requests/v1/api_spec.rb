require 'rails_helper'

describe 'API', type: :apivore, order: :defined do
  subject { Apivore::SwaggerChecker.instance_for('/v1/swagger.json') }

  context 'and' do
    it 'tests all documented routes' do
      expect(subject).to validate_all_paths
    end
  end
end
