module ApiErrors
  class Error < StandardError
    attr_reader :status

    def initialize(message, status = :internal_server_error)
      super(message)
      @status = status
    end
  end

  class UnauthorizedError < Error
    def initialize(message = 'Unauthorized')
      super(message, :unauthorized)
    end
  end

  class AuthenticationError < Error
    def initialize(message)
      super(message, :unprocessable_entity)
    end
  end
end
