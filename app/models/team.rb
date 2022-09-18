class Team < ApplicationRecord
  has_many :orders
  has_many :games, through: :orders
  has_many :players

  validates :name, :short_name, presence: true
end
