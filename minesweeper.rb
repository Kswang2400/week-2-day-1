
require "./game/game"

game = Game.new
# p game.minefield.bomb_locations

game.play

# Notes
# input must be "X, Y" space and comma sensitive

# try to implement cursor movement and selection (mouse clicks?) for player inputs
# implement welcome screen like in chess
# add flag counter in header
