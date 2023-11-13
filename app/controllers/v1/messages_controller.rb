module V1
  class MessagesController < ApiController
    skip_before_action :authenticate_token!, only: :anonymous_create

    def create
      @message = Messages::MessageCreator.new(params: params, current_user: @current_user).call
    end

    def anonymous_create
      @message = Messages::AnonymousMessageCreator.new(params: params).call
    end

    def exchanged_users
      @exchanged_users = @current_user.exchanged_users
      render json: @exchanged_users
    end

    def index
      sent_messages = Message.where(sender_id: @current_user.id)
      received_messages = Message.where(receiver_id: @current_user.id)
      anonymous_messages = AnonymousMessage.where(receiver_id: @current_user.id)

      @messages = { sent_messages: sent_messages, received_messages: received_messages,
                    anonymous_messages: anonymous_messages }
    end
  end
end
