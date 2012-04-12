#!/usr/bin/ruby

require 'open-uri'
require 'nokogiri'

module ScoreWatch
  VERSION = "0.2"
end

require 'lib/ScoreWatch/match'

# url = "http://soccernet.espn.go.com/gamecast?id="
# game = ARGV[0]
# url+=game

# old_score = "0 - 0"

# html = Nokogiri::HTML(open(url))
# home_team = html.css(".team.home h3").first.content
# away_team = html.css(".team.away h3").first.content

# # If not started, wait to announce start
# started = FALSE
# waiting = FALSE
# while started == FALSE do
#   clock = html.css("##{game.to_s}clock").first
#   if clock['style'].include?("display:none") && waiting == FALSE
#     puts "Waiting for match to start..."
#     waiting = TRUE
#     sleep 30
#   elsif clock['style'].include?("display:none") && waiting == TRUE
#     sleep 30
#   else
#     start_message = "Match has started: #{home_team} v #{away_team}"
#     puts start_message
#     growl_input = "-n 'Gamecast' -m '#{start_message}'"
#     system("growlnotify #{growl_input}")
#     started = TRUE
#     waiting = FALSE
#     game_on = TRUE
#   end
# end

# while game_on == TRUE do
#   # Open gamecast page
#   html = Nokogiri::HTML(open(url))

#   # Check status of match
#   timeStatus = html.css("##{game.to_s}statusTabText").first.content
#   timeStatus.strip!
#   # If Full Time, end watcher
#   if timeStatus == "Full-time"
#     game_on = FALSE
#     puts "All over!"
#     growl_input = "-n 'Gamecast' -m 'Game over!'"
#     system("growlnotify #{growl_input}")
#     exit
#   end

#   time = html.css("##{game.to_s}clock").first
#   time = time.gsub(" ","").gsub("-","").gsub("'","")

#   scoreline = html.css(".matchup-score").first.content
#   scoreline.gsub("?","")
#   if scoreline != old_score
#     puts "#{time}: #{home_team} #{scoreline} #{away_team}"
#     growl_input = "-n 'Gamecast' -m '#{time}: Score was #{old_score}, but is now #{scoreline}'"
#     system("growlnotify #{growl_input}")
#     old_score = scoreline
#     goal_comment = html.css(".select-comment").first
#     goal_text = ""
#     if goal_comment
#       goal_comment.css("b").each do |text|
#         goal_text+=text.content
#       end
#       puts "#{goal_text}\n\n"
#       growl_input = "-n 'Gamecast' -m '#{goal_text}'"
#       system("growlnotify #{growl_input}")
#     end
#   end
#   sleep 30
# end
