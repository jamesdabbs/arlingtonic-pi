require_relative "./launchpad"
require_relative "./cell"

module Board
  class Base
    def initialize
      @log_level = 0
      @rows = 10.times.map do |y|
        10.times.map do |x|
          Cell.new self,x,y
        end
      end
    end

    def each_cell
      return enum_for(:each_cell) unless block_given?
      rows.each do |row|
        row.each do |cell|
          yield cell
        end
      end
    end

    def [] x,y
      rows[y][x]
    end

    def log msg, level: 0
      warn msg if level <= log_level
    end

    private

    attr_reader :rows, :log_level

    def log_level= new_level
      @log_level = new_level
      warn "Log level is now: #{log_level}"
    end
  end


  class Padded < Base
    Event = Struct.new :type, :velocity

    def each_press
      return enum_for(:listen) unless block_given?
      loop do
        pad.each_event do |data|
          pre, pos, v = data[:data]

          log "Got event #{data}", level: 2

          next unless pre == 144 || pre == 176

          cell = number_to_cell(pos)
          if cell.at?(1,9) && v.zero?
            self.log_level += 1
          elsif cell.at?(2,9) && v.zero?
            self.log_level -= 1
          end

          yield [cell, Event.new(pre, v)]
        end
      end
    end

    def method_missing name, *args
      if pad.respond_to? name
        args.unshift cell_to_number(args.shift)
        pad.send name, *args
      else
        super
      end
    end

    def respond_to_missing name, *args
      pad.respond_to?(name) || super
    end

    private

    def pad
      @_pad ||= launch_pad
    end

    def launch_pad
      p = Launchpad.new
      p.programmer_mode!
      p.reset
      p
    end

    def number_to_cell n
      x = (n % 10)
      y = (n / 10)
      self[x,y]
    end

    def cell_to_number cell
      (cell.y * 10) + cell.x
    end
  end
end
