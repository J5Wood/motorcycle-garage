class Brand < ActiveRecord::Base
    has_many :motorcycles
    has_many :users, through: :motorcycles
end