module Auth
  class UserCreator
    attr_reader :user_params

    def initialize(user_params:)
      @user_params = user_params
    end

    def create!
      user = User.create!(user_params)

      token = JsonWebToken.encode(user_id: user.id) if user

      [token, user]
    end
  end
end
