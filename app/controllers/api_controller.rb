class ApiController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_token!

  private

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
