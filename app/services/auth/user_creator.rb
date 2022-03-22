module Auth
    class UserCreator
        attr_reader :user_params

        def initialize(user_params:)
           @user = User.new(user_params);
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
