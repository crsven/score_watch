# Score Watch (until a better name comes to me)

### Description
Takes an ESPN Gamecast match ID and scrapes the Gamecast page repeatedly to gather score updates. These are output on the command line and also in Growl (currently via [growlnotify](http://growl.info/extras.php#growlnotify))

### Installation
```
$ (sudo) gem install ScoreWatch
$ score_watch <GameCast ID>
```

### TODO
* Stop using Growlnotify in favor of a Ruby growl library
* Allow for command line only
* Scrape a lower-density page for info, such as the day's list of games
* Allow for multiple games to be watched
* Add case for extra time
