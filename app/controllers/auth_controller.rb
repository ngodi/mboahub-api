class AuthController < ApiController
    skip_before_action :authenticate_token!

    def login
      @user, @token = Auth::UserAuthenticator.new(
        email: params[:email],
        password: params[:password]
      ).authenticate!

        render json: { errors: [@user.errors.full_messages] } if @user.errors.any?
      return @user, @token
    end

    def signup
      @user, @token = Auth::UserCreator.new(user_params: params[:user]).create!

     render json: { errors: [@user.errors.full_messages] } if @user.errors.any?

      return @user, @token
    end

    def logout
      token = request.headers['Authorization']&.split(' ')&.last
      @token = JsonWebToken.destroy(token)
    end
end
