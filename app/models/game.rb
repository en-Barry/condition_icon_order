class Game < ApplicationRecord
  has_many :orders
  has_many :teams, through: :orders

  validates :start_at, :home_team_id, :visitor_team_id, presence: true
end
