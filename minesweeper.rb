
require_relative "game"

game = Game.new
p game.minefield.bomb_locations

game.play

# input must be "X, Y" space and comma sensitive
# try to implement cursor movement and selection for player inputs
# implement welcome screen like in chess

# colorize

# String.modes
# default, bold, underline, blink, swap, hide