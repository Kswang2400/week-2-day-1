
require_relative "board"

class Game
  attr_reader :minefield

  def initialize
    @minefield = Board.new
    @winner = false
    @loser = false
  end

  def flag_all
    @minefield.bomb_locations.each do |pos|
      flag(pos)
    end
  end

  def flag(pos)
    @minefield.all_tiles[pos[0]][pos[1]].flagged = true
    @minefield.all_tiles[pos[0]][pos[1]].revealed = true
    @minefield.board_view[pos[0]][pos[1]] = "  ⚑   "
  end

  def get_coord
    puts "\nTake your turn, input coordinate e.g. 2, 4"
    pos = gets.chomp
    return "win now" if pos == "win now"
    pos.split(", ").map! { |el| el.to_i }
  end

  def get_turn_type
    puts "\nReveal or Flag, (1) for reveal, (2) for flag"
    action = gets.chomp
    return "win now" if action == "win now"
    Integer(action)
  end

  def lose?
    if @loser == true
      puts "\n\nYou lose :(\n\n"
      return true
    end
  end

  def play
    until won? || lose?
      @minefield.show_board
      this_turn_position = get_coord
      type_of_turn = get_turn_type

      if this_turn_position == "win now" || type_of_turn == "win now"
        flag_all
      end

      if type_of_turn == 1
        reveal(this_turn_position)
      elsif type_of_turn == 2
        flag(this_turn_position)
      end
    end

    if @winner
      reveal_all_when_win
      @minefield.show_board
      puts "\n\nGood job!\n\n"
    elsif @loser
      reveal_all_when_lose
      @minefield.show_board
      puts "\n\nNice try\n\n"
    end
  end

  def reveal(pos)
    current_tile = @minefield.all_tiles[pos[0]][pos[1]]

    if current_tile.options[:bombed] == true
      @loser = true
      return
    elsif current_tile.options[:number] > 0
      current_tile.revealed = true
      @minefield.board_view[pos[0]][pos[1]] = "  #{current_tile.options[:number]}   "
    else
      current_tile.revealed = true
      @minefield.board_view[pos[0]][pos[1]] = "  _   "
      unrevealed_neighbors(pos)
    end
  end

  def reveal_all_when_lose
    @minefield.board_view.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        @minefield.board_view[i][j] = "  💣   " if @minefield.bomb_locations.include?([i, j])
      end
    end
  end

  def reveal_all_when_win
    @minefield.board_view.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        @minefield.board_view[i][j] = "   _  " if tile == "  []  "
      end
    end
  end

  def unrevealed_neighbors(pos)
    all_directions = [
      [-1, 1],  [0, 1],  [1, 1],
      [-1, 0],           [1, 0],
      [-1, -1], [0, -1], [1, -1]
    ]

    all_directions.each do |change|
      neighbor = [change[0] + pos[0], change[1] + pos[1]]
      next unless (0..8).include?(neighbor[0]) && (0..8).include?(neighbor[1])
      unless @minefield.all_tiles[neighbor[0]][neighbor[1]].revealed
        reveal(neighbor)
      end
    end
  end


  def won?
    flag_count = 0
    count = 0
    (0..8).each do |x|
      (0..8).each do |y|
        tile = @minefield.all_tiles[x][y]
        count += 1 if tile.flagged && tile.options[:bombed]
        flag_count += 1 if @minefield.board_view[x][y] == "  ⚑   "
      end
    end

    @winner = true if count == 10 && flag_count == 10
  end
end

