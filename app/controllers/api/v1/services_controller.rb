class Api::V1::ServicesController < ApplicationController
    before_action :authenticate_request
    before_action :set_service, only: [:show, :update]
  
    def index
      @services = Service.all
      render json: @services.to_json(:include => :user)
    end
  
    def show
      @service = Service.find(params[:id])
      render json: @service
    end
  
    def create
      @service = Service.new(service_params)
  
      if @service.save
        render json: @service, status: :created
      else
        render json: @service.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @service.update(service_params)
        render json: @service, status: 200
      else
        render json: { error: 'Unable to update service.' }, status: 400
      end
    end
  
    def destroy
      @service = Service.find(params[:id])
      if @service
        @service.destroy
        render json: { error: 'Unable to create service.' }, status: 200
      else
        render json: { error: 'Unable to delete service.' }, status: 400
      end
    end
  
    private
      def service_params
        params.require(:service).permit(:title, :description, :request_type, :latitude, :longitude, :status, :user_id)
      end
    
      def set_service
        @service = Service.find(params[:id])
      end
end
  