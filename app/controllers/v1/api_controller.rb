module V1
  class ApiController < ActionController::API
    include HandleResponse
    include HandlePagination

    rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_error
    rescue_from ActiveRecord::Validations, with: :validation_error
    rescue_from ActiveRecord::NotNullViolation, with: :invalid_error
    rescue_from ActiveRecord::RecordNotUnique, with: :validation_error
    rescue_from ApiErrors::UnauthorizedError, with: :handle_unauthorized
    rescue_from ApiErrors::Error, with: :handle_server_error
    rescue_from ActiveStorage::IntegrityError, with: :handle_server_error

    before_action :set_default_format
    before_action :authenticate_token!

    private

    def set_default_format
      request.format = :json
    end

    def authenticate_token!
      user_token = AccessToken.find_by(token: auth_token)

      if user_token
        @current_user = user_token.user
      else
        handle_unauthorized
      end
    end

    def auth_token
      request.headers['Authorization']&.split(' ')&.last
    end
  end
end
