class Record < ApplicationRecord
  belongs_to :player

  validates :player_id, presence: true, uniqueness: true
end
