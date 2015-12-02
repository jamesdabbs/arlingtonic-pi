require "pry"
require "osc-ruby"

def msg *args
  @client ||= OSC::Client.new "localhost", 3337
  @client.send OSC::Message.new *args
end

binding.pry
