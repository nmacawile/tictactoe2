require_relative 'game'
require_relative 'player'
include TicTacToe

puts "Match type:"
puts "   PP - Player vs Player"
puts "   PC or CP - Player vs Computer"
puts "   CC - Computer vs Computer"
print "Input: "
input = gets.chomp.upcase

p1class = nil
p2class = nil
p1name = nil
p2name = nil


case(input)
when 'PP'
	p1class = HumanPlayer
	p2class = HumanPlayer
when 'PC' || 'CP'
	p1class = HumanPlayer
	p2class = ComputerPlayer
	p2name = 'CPU'
when 'CC'
	p1class = ComputerPlayer
	p2class = ComputerPlayer
	p1name = 'CPU1'
	p2name = 'CPU2'
else
	puts "Invalid input. The game will now close."
end

unless p1class.nil? || p2class.nil?
	if p1class == HumanPlayer
		puts "Player 1, what is your name?: "
		p1name = gets.chomp
	end

	if p2class == HumanPlayer
		puts "Player 2, what is your name?: "
		p2name = gets.chomp
	end

	game = Game.new(p1class, p1name, p2class, p2name)
	game.play 
end