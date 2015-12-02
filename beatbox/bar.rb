class Bar
  attr_reader :current

  def initialize size: 4
    @size, @current = size, 0
  end

  def tick
    @current = (@current % @size) + 1
  end
end
