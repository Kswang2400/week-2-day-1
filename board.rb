
require 'colorize'
require_relative "tile"

class Board
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
    puts "\n\n"
    print_header

    @board_view.each_with_index do |line, i|
      print_two_empty_rows
      print "     ".on_red + "     #{i} ".on_blue.bold
      print_line(line)
      puts "     ".on_red + ((" ") * 100).on_blue + "     ".on_red
    end

    print_footer
  end

  def print_column_numbers
    print "     ".on_red + "   ".on_blue
    (0..8).each do |i|
      print "         #{i}".on_blue.bold
    end
    puts "       ".on_blue + "     ".on_red
  end

  def print_footer
    puts "     ".on_red + ((" ") * 100).on_blue + "     ".on_red
    print_column_numbers
    print_two_empty_rows
    puts (" " * 110).on_red
    puts (" " * 110).on_red
  end

  def print_header
    puts (" " * 110).on_red
    puts (" " * 110).on_red
    puts (" " * 34).on_red + "M   I   N   E   S   W   E   E   P   E   R!".on_red.bold + (" " * 34).on_red
    puts (" " * 110).on_red
    puts (" " * 110).on_red
    print_two_empty_rows
    print_column_numbers
  end

  def print_line(line)
    line.each do |space|
      print "  #{space}  ".on_blue
    end
    print "   ".on_blue
    puts "     ".on_red
  end

  def print_two_empty_rows
    puts "     ".on_red + ((" ") * 100).on_blue + "     ".on_red
    puts "     ".on_red + ((" ") * 100).on_blue + "     ".on_red
  end
end

