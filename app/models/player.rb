class Player < ApplicationRecord
  belongs_to :team
  has_one :record

  validates :name, :team_id, presence: true
end
