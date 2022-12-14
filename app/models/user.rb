class User < ApplicationRecord
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :clubs, -> { distinct }, through: :memberships

  validates :username, uniqueness: true, length: { in: 3..30 }
  validates :password, length: { minimum: 4 }, format: { with: /(?=.*[0-9])(?=.*[A-Z])/, message: "must have one capital letter and one numeral" }

  def favorite_beer
    return nil if ratings.empty?

    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_style
    return nil if ratings.empty?

    r = ratings.group_by { |rating| rating.beer.style.name }
    r.max_by{ |_k, v| v.map(&:score).sum / v.count.to_f }[0]
  end

  def favorite_brewery
    return nil if ratings.empty?

    r = ratings.group_by { |rating| rating.beer.brewery.name }
    r.max_by{ |_k, v| v.map(&:score).sum / v.count.to_f }[0]
  end

  def self.top(amount)
    User.all.sort_by{ |u| u.ratings.count }.reverse.take(amount)
  end
end
