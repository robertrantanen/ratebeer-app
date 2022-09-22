class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  # (?=.*[0-9])(?=.*[A-Z])
  validates :username, uniqueness: true, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[0-9])(?=.*[A-Z])/,
                                                         message: "must have one capital letter and one numeral" }
end
