class Order < ApplicationRecord
  belongs_to :team
  belongs_to :game

  validates :team_id, :game_id, presence: true 
end
