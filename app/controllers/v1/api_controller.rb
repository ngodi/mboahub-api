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

    def handle_server_error
      render json: { success: false, error: 'a server error occured, try again' }, status: :server_error
    end

    def handle_unauthorized
      render json: { success: false, error: 'user not unauthorized' }, status: :unauthorized
    end

    def set_default_format
      request.format = :json
    end

    def authenticate_token!
      user_token = AccessToken.find_by!(token: auth_token)

      if user_token
        @current_user = user_token.user
      else
        render json: { error: 'user not authorized' }, status: :unauthorized
      end
    end

    def auth_token
      request.headers['Authorization']&.split(' ')&.last
    end
  end
end
