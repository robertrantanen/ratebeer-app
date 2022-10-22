class Beer < ApplicationRecord
  include RatingAverage

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy
  has_many :raters, -> { distinct }, through: :ratings, source: :user

  validates :name, presence: true

  def to_s
    "#{name}, #{brewery.name}"
  end

  def self.top(amount)
    Beer.all.sort_by(&:average_rating).reverse.take(amount)
  end
end
