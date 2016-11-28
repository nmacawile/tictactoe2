require './player'
require './grid'
require './helper.rb'

module TicTacToe
	class Game
		
		private
		
		attr_reader :players
		
		attr_accessor :current_player_id
		
		public
		
		attr_accessor :grid
		
		def initialize(player1_class, player1_name, player2_class, player2_name)
			@players = [player1_class.new(self, player1_name, "X"), 
						player2_class.new(self, player2_name, "O")]
			@grid = Grid.new
			@current_player_id = 0
		end
		
		def new_grid
			self.grid = Grid.new
		end
		
		def play
			print_board
			loop do
				player_turn
				break if over?
				switch_player
			end
			show_scores
		end
		
		def player_turn
			current_player.turn
			print_board
		end
		
		def show_scores
			puts "scores here"
		end
		
		def print_board
			#grid.display_normal
			grid.display_numpad
		end
		
		def over?
			 win? || draw?
		end
		
		def draw?
			grid.full?
		end
		
		def win?
			grid.win?(current_player.symbol)
		end
		
		def current_player
			players[current_player_id]
		end
		
		def opponent
			players[current_player_id == 0 ? 1 : 0]
		end
		
		def switch_player
			self.current_player_id = current_player_id == 0 ? 1 : 0
		end
	end
end