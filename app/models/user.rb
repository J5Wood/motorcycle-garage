class User < ActiveRecord::Base
    has_secure_password
    has_many :motorcycles, dependent: :destroy
    has_many :brands, through: :motorcycles
end