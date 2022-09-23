class Club < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, -> { distinct }, through: :memberships
end
