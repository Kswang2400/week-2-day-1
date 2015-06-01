
require 'colorize'
require_relative "tile"
require_relative "printable"

class Board
  include Printable
  attr_reader   :bomb_locations
  attr_accessor :board_view, :all_tiles

  def initialize
    @board_view = Array.new(9) { Array.new(9) { "  []  " } }
    @all_tiles =  Array.new(9) { Array.new(9)}
    @bomb_locations = create_new_bombs

    create_tiles
  end

  def check_neighbors(pos)
    all_directions = [
      [-1, 1],  [0, 1],  [1, 1],
      [-1, 0],           [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]
    count = 0

    all_directions.each do |change|
      neighbor = [change[0] + pos[0], change[1] + pos[1]]
      if @bomb_locations.include? neighbor
        count += 1
      end
    end

    count
  end

  def create_new_bombs
    bombs = []

    until bombs.count == 10 do
      i = rand(9)
      j = rand(9)

      bombs << [i,j] unless bombs.include?([i,j])
    end

    bombs
  end

  def create_tiles
    (0..8).each do |x|
      (0..8).each do |y|

        if @bomb_locations.include?([x,y])
          tile = Tile.new(tile, { :bombed => true })
        else
          number = check_neighbors([x, y])

          if number == 0
            tile = Tile.new(tile, {})
          else
            tile = Tile.new(tile, { :number => number })
          end
        end

        @board_view[x][y] = "  []  "
        @all_tiles[x][y] = tile
      end
    end
  end

  def show_board
    print_header
    @board_view.each_with_index do |line, i|
      print_line(line, i)
    end
    print_footer
  end
end

