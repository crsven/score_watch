class TrollopUI
  def self.parse
    opts = Trollop::options do
      opt :growl, "Use Growlnotify for notifications"
      opt :cli, "Output on command line", :default => true
    end
  end
end
