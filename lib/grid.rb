require_relative 'cell'

module TicTacToe
	class Grid < Array
		VSEP = " | "
		HSEP = "\n----+---+----\n"
		
		PATTERNS = [[1, 2, 3], [4, 5, 6], [7, 8, 9],
					[1, 4, 7], [2, 5, 8], [3, 6, 9],
					[1, 5, 9], [3, 5, 7]]
		
		def initialize
			super(10) { |position| Cell.new(position) }
		end
		
		def win?(symbol)
			PATTERNS.each do |pattern| 
				if pattern.all? { |position| self[position].value == symbol }
					return true
				end
			end
			false
		end
		
		def full?
			self[1..9].all? { |cell| cell.marked? }
		end
		
		def free_positions
			(1..9).select { |position| self[position].free? }
		end
		
		def display_numpad
			row_display = lambda { |row| row.reverse.wrap_join(VSEP) }
			grid_display = self.reverse.to_3by3
			puts grid_display[0..2].collect(&row_display).wrap_join(HSEP)
		end
		
		def display_normal
			row_display = lambda { |row| row.wrap_join(VSEP) }
			grid_display = self[1..9].to_3by3
			puts grid_display.collect(&row_display).wrap_join(HSEP)
		end
	end
end