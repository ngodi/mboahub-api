module Auth
    class UserCreator
        attr_reader :first_name, :last_name, :email, :password, :password_confirmation, :city, :street

        def initialize(first_name:, last_name:, email:, password:, password_confirmation:, city:, street:)
           @user = User.new(
            first_name: first_name,
            last_name: last_name,
            email: email,
            password: password,
            password_confirmation: password_confirmation,
            city: city,
            street: street,
           )
        end

        def create!
           if @user.save
              @token = JsonWebToken.encode(user_id: @user.id)
              return @user, @token
           else
            @user
           end
        end
    end
end
