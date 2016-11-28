module TicTacToe
	class Cell
		
		attr_accessor :position, :value
		
		def initialize(position)
			@position = position
			@value = nil
		end
		
		def mark(symbol)
			if free?
				self.value = symbol
				true
			else
				false
			end
		end
		
		def free?
			value.nil?
		end
		
		def marked?
			!free?
		end
		
		def to_s
			free? ? position.to_s : value.to_s
		end
	end
end