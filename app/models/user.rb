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
    styles = styles_from_beers
    styles.max_by {|i| styles.count(i)}
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = breweries_from_beers
    breweries.max_by {|i| breweries.count(i)}
  end

  def beers_from_ratings
    return nil if ratings.empty?
    ratings.map{ |rating| rating.beer }
  end

  def styles_from_beers
    return nil if ratings.empty?
    beers = beers_from_ratings
    beers.map{ |beer| beer.style }
  end

  def breweries_from_beers
    return nil if ratings.empty?
    beers = beers_from_ratings
    beers.map{ |beer| beer.brewery.name }
  end
end
