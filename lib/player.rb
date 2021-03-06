require_relative 'game'
require_relative 'grid'

module TicTacToe
	class Player
		attr_reader :game, :name, :symbol
		attr_accessor :score
		
		def initialize(game, name, symbol)
			@game = game
			@name = name
			@symbol = symbol
			@score = 0
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
			print "#{self}'s turn (#{symbol}): "
			go_for_win || block ||
			center || escape || corner || setup || random 
		end

		def patterns
			Grid::PATTERNS
		end

		def fill_line
			moves = []
			patterns.each do |pattern| 
				if pattern.has_exactly?(2) { |pos| yield(pos) }
					cell = pattern.find { |pos| board[pos].free? }
					moves << cell unless cell.nil?
				end
			end

			unless moves.empty? 
				pick = moves.sample
				puts pick
				board[pick].mark(symbol)
			else
				false
			end
		end
		
		def go_for_win
			fill_line { |pos| board[pos].value == symbol }
		end

		def block
			fill_line { |pos| board[pos].value != symbol && board[pos].marked? }
		end

		def center
			if board[5].free?
				puts 5
				board[5].mark(symbol)
			else
				false
			end
		end

		def escape
			moves = []
			patterns.each do |pattern|
				if pattern.all? { |pos| pos.odd? } &&
				   pattern.values_at(0, 2).each { |pos| 
				   board[pos].marked? && board[pos].value != symbol 
				   } && 
				   board[pattern[1]].marked? && 
				   board[pattern[1]].value == symbol &&
				   board.free_positions.count do |pos|
						pos.odd?
					end == 2 &&
					 board.free_positions.count do |pos|
						pos.even?
					end == 4

					moves = board.free_positions.select do |pos|
						pos.even?
					end
				end
			end
			
			unless moves.empty? 
				pick = moves.sample
				puts pick
				board[pick].mark(symbol)
			else
				false
			end
		end

		def setup
			moves = []
			patterns.each do |pattern|
				if pattern.any? { |pos| board[pos].value == symbol } &&
				   pattern.none? { |pos| board[pos].marked? && board[pos].value != symbol }
					moves.concat(pattern.find_all { |pos| board[pos].free? })
				end
			end

			unless moves.empty? 
				pick = moves.sample
				puts pick
				board[pick].mark(symbol)
			else
				false
			end
		end

		def corner
			moves = board.free_positions.select do |pos|
				pos.odd?
			end
			
			unless moves.empty? 
				pick = moves.sample
				puts pick
				board[pick].mark(symbol)
			else
				false
			end
		end

		def random
			pick = board.free_positions.sample
			puts pick
			board[pick].mark(symbol)
		end
	end
end