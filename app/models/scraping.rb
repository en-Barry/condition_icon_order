require 'open-uri'
require 'nokogiri'

class Scraping < ApplicationRecord

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

  def self.get_player
    # hawks
    url = 'https://baseball.yahoo.co.jp/npb/teams/12/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id = Team.find_by(name: "福岡ソフトバンクホークス").id
    player_create_from_doc(doc, team_id)

    # buffaloes
    url = 'https://baseball.yahoo.co.jp/npb/teams/11/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "オリックス・バファローズ").id
    player_create_from_doc(doc, team_id)

    # chibaLotte
    url = 'https://baseball.yahoo.co.jp/npb/teams/9/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "千葉ロッテマリーンズ").id
    player_create_from_doc(doc, team_id)

    # rakutenEagles
    url = 'https://baseball.yahoo.co.jp/npb/teams/376/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "東北楽天ゴールデンイーグルス").id
    player_create_from_doc(doc, team_id)

    # fighters
    url = 'https://baseball.yahoo.co.jp/npb/teams/8/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "北海道日本ハムファイターズ").id
    player_create_from_doc(doc, team_id)

    # seibuLions
    url = 'https://baseball.yahoo.co.jp/npb/teams/7/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "埼玉西武ライオンズ").id
    player_create_from_doc(doc, team_id)

    # swallows
    url = 'https://baseball.yahoo.co.jp/npb/teams/2/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "東京ヤクルトスワローズ").id
    player_create_from_doc(doc, team_id)

    # tigers
    url = 'https://baseball.yahoo.co.jp/npb/teams/5/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "阪神タイガース").id
    player_create_from_doc(doc, team_id)

    # giants
    url = 'https://baseball.yahoo.co.jp/npb/teams/1/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "読売ジャイアンツ").id
    player_create_from_doc(doc, team_id)

    # carp
    url = 'https://baseball.yahoo.co.jp/npb/teams/6/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "広島東洋カープ").id
    player_create_from_doc(doc, team_id)

    # dragons
    url = 'https://baseball.yahoo.co.jp/npb/teams/4/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "中日ドラゴンズ").id
    player_create_from_doc(doc, team_id)

    # baystars
    url = 'https://baseball.yahoo.co.jp/npb/teams/3/memberlist?kind=b'
    doc = doc_from_url(url)
    team_id =  Team.find_by(name: "横浜DeNAベイスターズ").id
    player_create_from_doc(doc, team_id)
  end

  private

  def self.doc_from_url(url)
    html = URI.open(url).read
    doc = Nokogiri::HTML.parse(html)
    return doc
  end

  def self.player_create_from_doc(doc, team_id)
    doc.css(".bb-playerTable__data--player").children.children.each do |player_name|
      Player.create!(name: player_name.text.strip, team_id: team_id) unless Player.find_by(name: player_name.text.strip).present?
    end
  end
end