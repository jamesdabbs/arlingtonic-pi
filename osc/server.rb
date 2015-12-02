require "osc-ruby"
require "osc-ruby/em_server"

server = OSC::EMServer.new 3337
server.add_method "/ping" do |m|
  puts "Got /ping: #{m.inspect} - #{m.to_a}"
end

server.add_method "/hello" do |m|
  msg = m.to_a.first || "hello world"
  system "say", msg.gsub(/\W+/, '')
end

server.run
