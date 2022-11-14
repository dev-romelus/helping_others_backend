class User < ApplicationRecord
    has_secure_password
    has_many :services
    has_one_attached :identityDocument

    validates :email, :presence => true, uniqueness: true

    def identity_document
        Rails.application.routes.url_helpers.url_for(identityDocument) if identityDocument.attached?
    end
end
