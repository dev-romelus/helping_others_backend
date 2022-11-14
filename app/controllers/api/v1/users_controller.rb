class Api::V1::UsersController < ApplicationController
    before_action :authenticate_request
    before_action :set_user, only: [:show, :update]

    def index
        @users = User.all
        render json: @users, status: :created
    end

    def show
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    end

    def latest
        @user = User.last
        render json: UserSerializer.new(@user).serializable_hash[:data][:attributes]
    end

    def update
        if @user.update(user_params)
          render json: UserSerializer.new(@user).serializable_hash[:data][:attributes], status: :ok
        else
          render json: @user.errors, status: :unprocessable_entity
        end
    end

    private
        def user_params
            params.permit(:lastName, :firstName, :email, :password, :identityDocument)
        end

        def set_user
            @user = User.find(params[:id])
        end
end
