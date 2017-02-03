class Array
	def wrap_join(char)
		"#{char}#{self.join(char)}#{char}".strip
	end
	
	def to_3by3
		grid = []
		self.each_slice(3) { |*row| grid.push(*row) }
		grid
	end

	def has_exactly?(count)
    	if block_given?
    		matches=0
    		self.each do |item|
    			if yield(item)
    				matches += 1
    			end
    		end
    		return true if matches == count
    	else
    		return true
    	end
    	false
    end
end