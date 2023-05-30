module V1
  class ApiController < ApplicationController
    include HandleResponse
    include HandlePagination

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_error
    rescue_from ActiveRecord::Validations, with: :validation_error
    rescue_from ActiveRecord::NotNullViolation, with: :invalid_error

    before_action :set_default_format
    before_action :authenticate_token!

    private

    def set_default_format
      request.format = :json
    end

    def authenticate_token!
      payload = JsonWebToken.decode(auth_token)
      @current_user = User.find(payload['user_id'])
    rescue JWT::ExpiredSignature
      render json: { errors: ['Auth token has expired'] }, status: :unauthorized
    rescue JWT::DecodeError
      render json: { errors: ['Invalid auth token'] }, status: :unauthorized
    end

    def auth_token
      @auth_token ||= request.headers['Authorization']&.split(' ')&.last
    end
  end
end
