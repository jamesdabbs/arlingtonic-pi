require "pry"

require "osc-ruby"
require "osc-ruby/em_server"

require_relative "./drum_machine"
require_relative "./sonic_pi"

port   = ARGV.shift || 3333
server = OSC::EMServer.new port
dm     = DrumMachine.new
sonic  = SonicPi.new


# -- Server for SonicPi ===> Drum Machine communications ----

server.add_method "/beat" do |m|
  begin
    beat = dm.tick
    print "\rbeat #{beat}"
  rescue => e
    warn "OSC Server Error - #{e}"
  end
end
Thread.new { server.run }


# -- Laptop <=> Launchpad interaction ----

dm.press (1..8), (1..3) do |cell, event|
  dm.toggle cell, event.velocity
end


# -- Laptop => Sonic Pi sync
dm.press 9, 1 do
  sonic.update_buffer 1, dm.drum_roll
end

dm.listen
