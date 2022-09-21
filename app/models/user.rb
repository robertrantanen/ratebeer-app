class User < ApplicationRecord
    include RatingAverage

    has_secure_password
    
    has_many :ratings
    has_many :beers, through: :ratings

    validates :username, uniqueness: true, length: { in: 3..30  }
    validates :password, length: { minimum: 4 }
end
