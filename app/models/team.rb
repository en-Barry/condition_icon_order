require 'open-uri'
require 'nokogiri'

class Team < ApplicationRecord
  has_many :orders
  has_many :games, through: :orders
  has_many :players

  validates :name, presence: true, uniqueness: true
end
