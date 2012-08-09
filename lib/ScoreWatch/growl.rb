class Growl
  GROWL_OPTIONS = "-n 'Score Watch'"

  def self.message(text)
    growl_input = "#{GROWL_OPTIONS} -m '#{text}'"
    system("growlnotify #{growl_input}")
  end
end
