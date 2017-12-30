class V1::SwaggersController < ApplicationController
  def show
    render json: YAML.load_file(Rails.configuration.swagger_yaml_path)
  end
end
