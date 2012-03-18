Gem::Specification.new do |s|
  s.name         = 'Score_Watch'
  s.version      = '0.2.0'
  s.summary      = 'Watches ESPN Gamecast pages for updates and broadcasts those updates.'
  s.description  = 'Given an ESPN Gamecast match ID, Score Watch will scrape the Gamecast Page for updates and broadcast them on the command line and also via GrowlNotify.'
  s.authors      = ["Chris Svenningsen"]
  s.email        = 'crsven@gmail.com'
  s.files        = ["lib/score_watch.rb"]
  s.homepage     = 'http://www.crsvenningsen.com/projects'
  s.require_path = '.'
end
