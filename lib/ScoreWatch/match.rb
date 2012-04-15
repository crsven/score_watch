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
  PING_TIME = 30

  def initialize(id)
    @match_id = id
    @match_url = "http://soccernet.espn.go.com/gamecast?id=#{@match_id}"
    @current_time = nil
    @old_score = "0 - 0"
    @current_score = nil
    @started = false
    #combine?
    @game_on = false
    @status = nil
    get_teams
    watch
  end

  def watch
    refresh
    get_score
    get_status
    if @old_score != @current_score
      comment = get_goal_comment
      message("#{@home_team} #{@current_score} #{@away_team}")
      message(comment)
    end
    wait
    watch
  end

  private

  def refresh
    @html = Nokogiri::HTML(open(@match_url))
    @current_time = get_current_time
  end

  def get_teams
    refresh
    @home_team = @html.css(".team.home h3").first.content
    @away_team = @html.css(".team.away h3").first.content
  end

  def get_score
    refresh
    @old_score = @current_score
    scoreline = @html.css(".matchup-score").first.content
    scoreline.gsub("?","")
    @current_score = scoreline
  end

  def get_goal_comment
    refresh
    goal_text = @html.css(".select-comment").first
    goal_comment = ""
    if goal_text
      goal_comment = goal_text.css(".comment").first.content
    end
  end

  def get_status
    if @game_on == true
      if is_over?
        message("Match ended! Final score: #{@home_team} #{current_score} #{@away_team}")
        exit
      end
      return
    elsif is_started?
      message("Match has started:\n#{@current_time}: #{@home_team} v. #{@away_team}")
      @game_on = true
    elsif is_over?
      message("Match ended! Final score: #{@home_team} #{current_score} #{@away_team}")
      exit
    else
      message("Waiting for match to start.")
    end
  end

  def wait
    sleep PING_TIME
  end

  def is_started?
    refresh
    clock = @html.css("##{@match_id.to_s}clock").first
    if clock['style'].include?("display:none")
      return false
    else
      return true
    end
  end

  def get_current_time
    clock = @html.css("##{@match_id.to_s}clock").first.content
    time = clock.gsub(" ","").gsub("-","").gsub("'","")
  end

  def is_over?
    refresh
    timeStatus = @html.css("##{@match_id.to_s}statusTabText").first.content
    timeStatus.strip!
    if timeStatus == "Full-time"
      return true
    else
      return false
    end
  end

  def growl(text)
    growl_input = "#{GROWL_OPTIONS} -m '#{text}'"
    system("growlnotify #{growl_input}")
  end

  def message(text)
    growl(text)
    puts(text)
  end
end
