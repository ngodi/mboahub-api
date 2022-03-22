module Auth
    class UserAuthenticator
        attr_reader :email, :password

        def initialize( email:, password:)
            @email = email
            @password = password
        end

        def authenticate!
            user = User.find_by!(email: email)
            user.authenticate(password)
            token = { token: JsonWebToken.encode(user_id: user.id)}

             return user, token
        end
    end
end
