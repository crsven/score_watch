# Init
# - get_teams
# - get_status
# IF WAIT
#   - wait, get_status
# IF GAME ON
#   - get_score, wait
# IF OVER
#   - get_score, end
#
class ScoreWatch::Match
  GROWL_OPTIONS = "-n 'Score Watch'"
  def initialize(id)
    @match_id = id
    @match_url = "http://soccernet.espn.go.com/gamecast?id=#{@match_id}"
    @current_time = nil
    @old_score = "0 - 0"
    @current_score = nil
    @started = FALSE
    #combine?
    @game_on = FALSE
    @status = nil
    get_teams
  end

  def watch
    # get_status
    refresh
    @status = get_status
    if @status == "waiting"
    elsif @status == "playing"
    elsif @status == "match_over"
      growl("Match ended! Final score: #{@home_team} #{current_score} #{@away_team}")
    end
    # output status
    # wait
  end

  private

  def refresh
    @html = Nokogiri::HTML(open(@match_url))
  end

  def get_teams
    refresh
    @home_team = @html.css(".team.home h3").first.content
    @away_team = @html.css(".team.away h3").first.content
  end

  def current_score
    refresh
    scoreline = html.css(".matchup-score").first.content
    scoreline.gsub("?","")
    return scoreline
  end

  def get_status
    if is_started?
      return "playing"
    elsif is_over?
      return "match_over"
    else
      return "waiting"
    end
  end

  def wait
    sleep 30
  end

  def is_started?
    refresh
    clock = html.css("##{game.to_s}clock").first
    if clock['style'].include?("display:none")
      return false
    else
      return true
    end
  end

  def is_over?
    refresh
    timeStatus = html.css("##{game.to_s}statusTabText").first.content
    timeStatus.strip!
    if timeStatus == "Full-time"
      return TRUE
    else
      return FALSE
    end
  end

  def growl(text)
    growl_input = "#{GROWL_OPTIONS} -m '#{text}'"
    system("growlnotify #{growl_input}")
  end
end
