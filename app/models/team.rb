require 'open-uri'
require 'nokogiri'

class Team < ApplicationRecord
  has_many :orders
  has_many :games, through: :orders
  has_many :players

  validates :name, presence: true, uniqueness: true

  def self.get_teams
    url = 'https://baseball.yahoo.co.jp/npb/teams/'  
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)

    doc.css('.bb-teamHead__title').children.children.each do |team_name|
      team = Team.new
      team.name = team_name.text
      team.save!
    end
  end
end
