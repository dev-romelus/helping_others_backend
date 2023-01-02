class Api::V1::AuthenticationController < ApplicationController
    def login
        @user = User.find_by(email: params[:email])    
    
        if @user && @user.authenticate(params[:password])
            token = jwt_encode({ user_id: @user.id })
            render json: { token: token, user: @user }, status: 200
        else
            render json: { error: 'Your email or password invalid.' }, status: :unauthorized
        end
    end

    def signup
        @user = User.new(user_params)
    
        if @user.save
          token = jwt_encode({ user_id: @user.id })
          render json: { token: token, user: @user }, status: 201
        else
          render json: { error: 'Unable to create user.' }, status: 400
        end
    end

    private
        def user_params
            params.permit(:lastName, :firstName, :email, :password, :filename, :identity_document_url)
        end

end
