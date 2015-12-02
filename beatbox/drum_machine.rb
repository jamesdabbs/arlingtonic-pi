require_relative "./bar"
require_relative "./board"
require_relative "./press_listener"

class DrumMachine
  def initialize
    @board = Board::Padded.new
    @bar   = Bar.new
    @board.pulse @board[9,9], RED
    @listeners = []
  end

  def press *args, &block
    @listeners.push PressListener.new *args, &block
  end

  def listen
    @board.each_press do |cell, event|
      @listeners.each { |l| l.handle cell, event }
    end
  end

  def toggle cell, velocity
    if cell.value == 0
      @board.rgb cell, velocity, velocity, 0
      cell.value = velocity
    else
      @board.rgb cell, 0, 0, 0
      cell.value = 0
    end
  end

  def tick
    @board.rgb cell_for_beat(@bar.current), 0, 0, 0
    @bar.tick
    @board.rgb cell_for_beat(@bar.current), 127, 0, 0
    @bar.current
  end

  def cell_for_beat n
    @board[(2 * n) - 1, 4]
  end

  def drum_roll
    {
      hat:   3,
      snare: 2,
      kick:  1
    }.map { |name, y| "#{name}\t[#{serialize y}]" }.join "\n"
  end

  def serialize y
    1.upto(8).map do |x|
      cell = @board[x,y]
      (100 * cell.value / 127.0).to_i.to_s.rjust(3)
    end.join ","
  end
end
