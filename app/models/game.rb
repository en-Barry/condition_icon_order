class Game < ApplicationRecord
  has_many :orders
  has_many :teams, through: :orders
end
