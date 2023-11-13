module Messages
  class AnonymousMessageCreator
    def initialize(params:)
      @params = params
    end

    def call
      AnonymousMessage.create!(
        content: @params[:content],
        sender_email: @params[:sender_email],
        sender_phone: @params[:sender_phone],
        sender_name: @params[:sender_name],
        receiver_id: @params[:receiver_id],
        house_id: @params[:house_id]
      )
    end
  end
end
