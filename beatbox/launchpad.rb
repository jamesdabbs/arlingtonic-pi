require "unimidi"

BLACK              = 0
WHITE              = 3
LIGHT_RED          = 4
RED                = 5
YELLOW             = 13
GREEN              = 21
LIGHT_BLUE         = 36
BLUE               = 69
REALLY_LIGHT_WHITE = 71

class Launchpad
  def initialize input: nil, output: nil
    @in  = input  || UniMIDI::Input[1]
    @out = output || UniMIDI::Output[1]
  end

  def programmer_mode!
    select_mode 3
  end

  def configure in_=nil, out=nil
    @in  = in_ || UniMIDI::Input.gets
    @out = out || UniMIDI::Output.gets
  end

  def each_event
    @in.gets.each { |e| yield e }
  end

  def col col=0, color=0
    colors = [color] * 10
    sysex 12, col, *colors
  end

  def row row=0, color=0
    colors = [color] * 10
    sysex 13, row, *colors
  end

  def reset color=0
    sysex 14, color
  end

  def light cell, color=0
    sysex 10, cell, color
  end

  def rgb cell, r, g, b
    sysex 11, cell, r, g, b
  end

  def blink cell, color=0
    sysex 35, cell, color
  end

  def pulse cell, color=0
    sysex 40, cell, color
  end

  def scroll text, color: 1, loop: 0, speed: 4
    sysex 20, color, loop, speed, *text.split("").map(&:ord)
  end

  def select_mode mode
    sysex 44, mode
  end

  def sysex *bytes
    out.puts 240, 0, 32, 41, 2, 16, *bytes, 247
  end

  private

  attr_reader :in, :out
end

if $PROGRAM_NAME == __FILE__
  require "pry"
  p = Launchpad.new
  binding.pry
end
