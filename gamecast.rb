#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'

url = "http://soccernet.espn.go.com/gamecast?id="
game = ARGV[0]
url+=game

old_score = "0-0"
while game_on = TRUE do
  html = Nokogiri::HTML(open(url))
  time = html.css("##{game.to_s}clock").first.content
  time = time.gsub(" ","").gsub("-","").gsub("'","")
  if time == "FT"
    game_on = FALSE
    puts "All over!"
    growl_input = "-n 'Gamecast' -m 'Game over!'"
    system("growlnotify #{growl_input}")
  end

  scoreline = html.css(".matchup-score").first.content
  scoreline.gsub("?","")
  if scoreline != old_score
    puts "#{time}: #{scoreline}"
    growl_input = "-n 'Gamecast' -m '#{time}: Score was #{old_score}, but is now #{scoreline}'"
    system("growlnotify #{growl_input}")
    old_score = scoreline
  end

  sleep 30
end
