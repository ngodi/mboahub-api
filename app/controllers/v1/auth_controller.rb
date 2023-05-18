module V1
  class AuthController < ApiController
    skip_before_action :authenticate_token!

    def login
      @token = Auth::UserAuthenticator.new(email: params[:email], password: params[:password]).authenticate!

      return render_422_response(Struct.new(:errors).new('Invalid password')) if @token == false

      @token
    end

    def signup
      @token, @user = Auth::UserCreator.new(user_params: user_params).create!

      return render_422_response(@user) if @user.nil?

      [@token, @user]
    end

    def logout
      token = request.headers['Authorization']&.split(' ')&.last
      @token = JsonWebToken.destroy(token)
    end

    def home
      render json: 'Welcome'
    end

    private

    def user_params
      params.require(:auth).permit(:first_name, :last_name, :email, :password, :password_confirmation,
                                   address: %i[city street])
    end
  end
end
