class V1::UsersController < ApplicationController
  before_action :set_v1_user, only: [:show, :update, :destroy]

  # GET /v1/users
  def index
    @v1_users = V1::User.all

    render json: @v1_users
  end

  # GET /v1/users/1
  def show
    render json: @v1_user
  end

  # POST /v1/users
  def create
    @v1_user = V1::User.new(v1_user_params)

    if @v1_user.save
      render json: @v1_user, status: :created, location: @v1_user
    else
      render json: @v1_user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v1/users/1
  def update
    if @v1_user.update(v1_user_params)
      render json: @v1_user
    else
      render json: @v1_user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v1/users/1
  def destroy
    @v1_user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_v1_user
      @v1_user = V1::User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def v1_user_params
      params.fetch(:v1_user, {})
    end
end
