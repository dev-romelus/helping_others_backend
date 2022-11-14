class Api::V1::ConversationsController < ApplicationController
    before_action :authenticate_request
  
    def index
      @users = User.where.not(id: @current_user.id)
      @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", @current_user.id, @current_user.id)
      
      render json: @conversations, include: ['sender', 'receiver', 'service']
    end
  
    def create
      @count = Conversation.where(service_id: params[:service_id]).count
  
      if @count == 5
        @service = Service.find_by(id: params[:service_id]);
        @service.display = false
        @service.save
      end
  
      @conversationFound = Conversation.find_by(service_id: params[:service_id], sender_id: params[:sender_id])
      if @conversationFound
        render json: { conversation: @conversationFound, conversationExists: true }, status: :ok
      else
        @conversation = Conversation.create!(conversation_params)
        render json: { conversation: @conversation, conversationExists: false }, status: :ok
      end
    end
  
    private
      def conversation_params
        params.permit(:sender_id, :receiver_id, :service_id)
      end
end
  