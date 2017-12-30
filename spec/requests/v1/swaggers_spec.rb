require 'rails_helper'

RSpec.describe "V1::Swagger", type: :request do
  describe "GET /v1/swagger" do
    it "no routes error" do
      expect { get v1_swagger_path }.to raise_error ActionController::RoutingError
    end
  end

  describe "GET /v1/swagger.json" do
    it "return swagger.json" do
      get v1_swagger_path(format: :json)

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq "application/json"
      expect { JSON(response.body) }.not_to raise_error
      expect(JSON(response.body)['swagger']).to eq '2.0'
    end
  end
end
