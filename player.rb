require './game'
require './grid'

module TicTacToe
	class Player
		attr_reader :game, :name, :symbol
		
		def initialize(game, name, symbol)
			@game = game
			@name = name
			@symbol = symbol
		end
		
		def board
			game.grid
		end
		
		def to_s
			name
		end
	end
	
	class HumanPlayer < Player
		def turn
			loop do
				print "#{self}'s turn (#{symbol}): "
				input = gets.chomp.to_i
				
				break if input.between?(1, 9) && board[input].mark(symbol)
				puts "#{self}: Invalid turn."
			end
		end
	end
	
	class ComputerPlayer < Player
		def turn
			go_for_win
			block
			center
			setup
			random
		end

		def patterns
			Grid::PATTERNS
		end
		
		def go_for_win
			patterns.each
		end

		def block

		end

		def center

		end

		def setup

		end

		def random

		end

		
		def to_s
			"CPU"
		end
	end
end