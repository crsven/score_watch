#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'

url = "http://soccernet.espn.go.com/gamecast?id="
game = ARGV[0]
url+=game

old_score = "0-0"
while game_on = TRUE do
  html = Nokogiri::HTML(open(url))
  scoreline = html.css(".matchup-score").first.content
  scoreline.gsub("?","")
  if scoreline != old_score
    puts scoreline
    growl_input = "-n 'Gamecast' -m 'Score was #{old_score}, but is now #{scoreline}'"
    system("growlnotify #{growl_input}")
    old_score = scoreline
  end

  time = html.css("##{game.to_s}clock").first.content
  if time.gsub(" ","").gsub("-","").gsub("'","") == "FT"
    game_on = FALSE
  end
  sleep 30
end
