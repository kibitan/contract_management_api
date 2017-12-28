class V1::SwaggersController < ApplicationController
  before_action :set_v1_swagger, only: [:show, :update, :destroy]

  # GET /v1/swaggers
  def index
    @v1_swaggers = V1::Swagger.all

    render json: @v1_swaggers
  end

  # GET /v1/swaggers/1
  def show
    render json: @v1_swagger
  end

  # POST /v1/swaggers
  def create
    @v1_swagger = V1::Swagger.new(v1_swagger_params)

    if @v1_swagger.save
      render json: @v1_swagger, status: :created, location: @v1_swagger
    else
      render json: @v1_swagger.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/swaggers/1
  def update
    if @v1_swagger.update(v1_swagger_params)
      render json: @v1_swagger
    else
      render json: @v1_swagger.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/swaggers/1
  def destroy
    @v1_swagger.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_swagger
      @v1_swagger = V1::Swagger.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def v1_swagger_params
      params.fetch(:v1_swagger, {})
    end
end
