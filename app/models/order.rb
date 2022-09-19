class Order < ApplicationRecord
  belongs_to :team
  belongs_to :game

  validates :team_id, :game_id, :batter_1, :batter_2, :batter_3, :batter_4, :batter_5, :batter_6, :batter_7, :batter_8, :batter_9, presence: true 
end
