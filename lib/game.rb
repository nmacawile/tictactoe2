require_relative 'player'
require_relative 'grid'
require_relative 'helper'

module TicTacToe
	class Game
		private
		
		attr_reader :players
		
		attr_accessor :current_player_id
		
		public
		
		attr_accessor :grid, :draws
		
		def initialize(player1_class, player1_name, player2_class, player2_name)
			@players = [player1_class.new(self, player1_name.colorize(:red), "X".colorize(:red)), 
						player2_class.new(self, player2_name.colorize(:blue), "O".colorize(:blue))]
			@grid = Grid.new
			@current_player_id = 0
			@draws = 0
		end
		
		def new_grid
			self.grid = Grid.new
		end
		
		def play
			loop do
				print_board
				self.current_player_id = rand(0..1)
				loop do
					player_turn
					break if over?
					switch_player
				end
				show_scores
				print "Play again? (Type in 'Y' to play again): "
				response = gets.chomp.upcase
				break unless response == "Y"
				new_grid
			end
		end
		
		def player_turn
			current_player.turn
			print_board
		end
		
		def show_scores
			puts
			puts "Scores:"
			players.each { |player|	puts "#{player}: #{player.score}" }
			puts "Draws: #{draws}"
			puts
		end
		
		def print_board
			#grid.display_normal
			grid.display_numpad
			puts
		end
		
		def over?
			 win? || draw?
		end
		
		def draw?			
			if grid.full?
				puts "It's a draw!"
				self.draws += 1
				true
			else
				false
			end
		end
		
		def win?
			if grid.win?(current_player.symbol)
				puts "#{current_player} wins!"
				current_player.score += 1
				true
			else
				false
			end
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