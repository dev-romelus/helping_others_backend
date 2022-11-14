class Api::V1::TasksController < ApplicationController
    def numberOfRequests
        @services = Service.where(status: true)
        @count = @services.count
        render json: @count
    end
end
