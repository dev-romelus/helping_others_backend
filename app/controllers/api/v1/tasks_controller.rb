class Api::V1::TasksController < ApplicationController
    def numberOfRequests
        @services = Service.where(status: 'IN_PROGRESS')
        @count = @services.count
        render json: @count
    end
end
