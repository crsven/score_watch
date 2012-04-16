require 'lib/ScoreWatch'

Gem::Specification.new do |s|
  s.name         = 'ScoreWatch'
  s.version      = ScoreWatch::VERSION
  s.summary      = 'Watches ESPN Gamecast pages for updates and broadcasts those updates.'
  s.description  = 'Given an ESPN Gamecast match ID, Score Watch will scrape the Gamecast Page for updates and broadcast them on the command line and also via GrowlNotify.'
  s.authors      = ["Chris Svenningsen"]
  s.email        = 'crsven@gmail.com'
  s.executables  = ["score_watch"]
  s.files        = Dir["{lib}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
  s.homepage     = 'http://www.crsvenningsen.com/projects'
  s.require_path = 'lib'
end
