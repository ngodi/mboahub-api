module V1
  class MessagesController < ApiController
    skip_before_action :authenticate_token!, only: :create

    def create
      @message = Message.create!(
        content: params[:content], 
        sender_id: params[:sender_id],
        receiver_id: params[:receiver_id]
      )
    end

    def exchanged_users
      @exchanged_users = @current_user.exchanged_users
      render json: @exchanged_users
    end
  
    def index
      sent_messages = Message.where(sender_id: @current_user.id)
      received_messages = Message.where(receiver_id: @current_user.id)
  
      @messages = { sent_messages: sent_messages, received_messages: received_messages }
    end
  end
end
