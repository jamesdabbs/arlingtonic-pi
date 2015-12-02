# Arlingonic Pi

Notes and code from my Arlington Ruby group presentation on [Sonic Pi](http://sonic-pi.net/) and building your own instruments.

The fun part is `beatbox/start.rb`, which hooks up a [Novation Launchpad](http://global.novationmusic.com/launch/launchpad) to Sonic Pi as a drum sequencer. When run, it:

* Starts an OSC server that Sonic Pi can send messages to (to trigger e.g. the "metronome" display)
* Listens for touch events in the "drum roll" area and records their velocity
* Allows you to send the drum pattern you've designed to Sonic Pi (both as sound playing live and as code in the UI to be iterated on) at the touch of a button.

All this assumes you have `beatbox/workspace.spi` loaded into a workspace and running and everything wired up correctly. If you're having any trouble running this, please ping me; I'd be happy to help.


## References / See Also

* The Sonic Pi side drum sequencer is adapted from [Darin Wilson's recent RubyConf talk](https://www.youtube.com/watch?v=exZTxhH06tw)
* [Sam Aaron's Strangeloop talk on the Sonic Pi](https://www.youtube.com/watch?v=YlRTTzlhquo) and the [corresponding paper about the timing model](https://www.cl.cam.ac.uk/~dao29/publ/farm14-aaron.pdf)
* Check out some [Sonic Pi livecoding](https://livecoding.tv/samaaron/) as well