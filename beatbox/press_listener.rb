class PressListener
  def initialize xs, ys, &block
    @xs, @ys, @block = xs, ys, block
  end

  def handle cell, event
    return unless event.velocity && event.velocity > 0
    if @xs === cell.x && @ys === cell.y
      @block.call cell, event
    end
  end
end
