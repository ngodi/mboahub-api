module Auth
  class UserAuthenticator
    attr_reader :email, :password

    def initialize(email:, password:)
      @email = email
      @password = password
    end

    def authenticate!
      user = User.find_by!(email: email)

      if user.authenticate(password)
        access_token = AccessToken.create(user_id: user.id)

        return { token: access_token.token }
      end

      false
    end
  end
end
