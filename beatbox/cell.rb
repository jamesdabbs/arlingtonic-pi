class Cell
  attr_reader :x,:y
  attr_accessor :value

  def initialize board, x,y
    @board,@x,@y = board,x,y
    @value = 0
  end

  def to_s
    "<Cell(#@x,#@y)>"
  end

  def inspect
    to_s
  end

  def central?
    x != 0 && x != 9 && y != 0 && y != 9
  end

  def at? x,y
    self.x == x && self.y == y
  end
end
