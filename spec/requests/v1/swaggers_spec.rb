require 'rails_helper'

RSpec.describe "V1::Swagger", type: :request do
  describe "GET /v1/swagger" do
    it "works! (now write some real specs)" do
      get v1_swagger_path
      expect(response).to have_http_status(200)
    end
  end
end
