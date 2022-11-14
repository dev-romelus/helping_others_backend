class Api::V1::MessagesController < ApplicationController
    before_action :authenticate_request

    before_action do
      @conversation = Conversation.find(params[:conversation_id])
    end

    def index
      @messages = @conversation.messages.order(created_at: :desc)

      @messages.where("user_id != ? AND read = ?", @current_user.id, false).update_all(read: true)
      render :json => @messages.to_json(:include => :user)
    end

    def create
      @message = @conversation.messages.new(message_params)
      @message.user = @current_user
      if @message.save
        render json: { message: @message }
      end
    end

    private
      def message_params
        params.require(:message).permit(:body, :user_id, :conversation_id, :service_id)
      end
end
  