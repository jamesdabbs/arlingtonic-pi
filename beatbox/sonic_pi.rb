class SonicPi
  def initialize
    @back = OSC::Client.new "localhost", 4557
    @ui   = OSC::Client.new "localhost", 4558
  end

  def back *args
    @back.send OSC::Message.new *args
  end

  def ui *args
    @ui.send OSC::Message.new *args
  end

  def update_buffer number, code
    back "/run-code",       number.to_s, code
    ui   "/replace-buffer", number.to_s, code, 0, 0, 0
  end
end
