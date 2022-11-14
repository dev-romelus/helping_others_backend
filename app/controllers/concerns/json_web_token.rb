require 'jwt'

module JsonWebToken
    extend ActiveSupport::Concern
    
    def jwt_encode(payload)
        JWT.encode(payload, 'top-secret-YHWH')
    end

    def jwt_decode(token)
        decoded = JWT.decode(token, 'top-secret-YHWH')[0]
        HashWithIndifferentAccess.new decoded
    end
    
end
