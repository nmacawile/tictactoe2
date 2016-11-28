class Array
	def wrap_join(char)
		"#{char}#{self.join(char)}#{char}".strip
	end
	
	def to_3by3
		grid = []
		self.each_slice(3) { |*row| grid.push(*row) }
		grid
	end

	def has_exactly(n)
		
	end
end