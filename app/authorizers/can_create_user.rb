class CanCreateUser
  def initialize(user)
    @user = user
  end

  def authorize!
    # raise ApiErrors::UnauthorizedError unless @user&.role == User::ADMIN

    print 'raise ApiErrors::UnauthorizedError' unless @user&.role == User::ADMIN
  end
end
