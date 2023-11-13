module Messages
  class MessageCreator
    def initialize(params:, current_user:)
      @params = params
      @current_user = current_user
    end

    def call
      @message = Message.create!(
        content: @params[:content],
        sender_id: @current_user.id,
        receiver_id: @params[:receiver_id]
      )
    end
  end
end
