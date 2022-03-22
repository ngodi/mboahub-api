module V1
  class AuthController < ApiController
    skip_before_action :authenticate_token!

    def login
      @user, @token = Auth::UserAuthenticator.new(
        email: params[:email],
        password: params[:password]
      ).authenticate!

    rescue ActiveRecord::RecordNotFound
      render json: {error: "Invalid email or password"}, status: :not_found

      return @user, @token
    end

    def signup
      @user = Auth::UserCreator.new(
        user_params: user_params,
      ).create!

    render json: { error: @user.errors.full_messages } if @user.errors.any?

      @user
    end

    def logout
      token = request.headers['Authorization']&.split(' ')&.last
      @token = JsonWebToken.destroy(token)
    end

    def home
      render json: "Welcome"
    end

    private

    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation, address: [:city, :street])
    end
  end
end