require './game'
require './player'
include TicTacToe


#game = Game.new(HumanPlayer, "a", ComputerPlayer, "b")
game = Game.new(ComputerPlayer, "a", ComputerPlayer, "b")
game.play