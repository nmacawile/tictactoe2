require 'player'
require 'grid'

describe TicTacToe::HumanPlayer do
	let(:game) { double }

	subject { 
		TicTacToe::HumanPlayer.new(game, "playername", "foo") 
	}

	describe "#turn" do

		let(:index) { double }
		let(:cell) { double }

		before do			
			allow(subject).to receive(:loop).and_yield
			allow(subject).to receive(:puts)
			allow(subject).to receive(:print)
					
		end

		after do
			subject.turn
		end

		context "when cell index is valid" do
			it "attempts to mark cell" do
				allow(subject).to receive_message_chain(:gets, :chomp, :to_i) { 9 }
				expect(game).to receive_message_chain(:grid, :[]).with(9) { cell }
				expect(cell).to receive(:mark).with("foo")
			end
		end

		context "when cell index is invalid" do
			it "won't attempt to cell" do
				allow(subject).to receive_message_chain(:gets, :chomp, :to_i) { 10 }
				expect(game).not_to receive(:grid)
				expect(cell).not_to receive(:mark)
			end
		end
	end
end

describe TicTacToe::ComputerPlayer do
	let(:game) { double }

	subject { TicTacToe::ComputerPlayer.new(game, "computer", "bar") }

	before do
		allow(game).to receive(:grid).and_return( TicTacToe::Grid.new )
		allow(subject).to receive(:print)
		allow(subject).to receive(:puts)
	end

	describe "#turn" do
		context "when about to win" do
			before do 
				[1, 3].each { |c| game.grid[c].mark("bar") }
				[4, 6].each { |c| game.grid[c].mark("foo") }
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:block)
			end

			it "marks the winning cell" do			
				expect { subject.turn }.to change(game.grid[2], :marked?).from(false).to(true)
			end

		end

		context "when about to lose" do
			before do
				[1, 7].each { |c| game.grid[c].mark("foo") }
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:center)
			end

			it "marks the winning cell" do			
				expect { subject.turn }.to change(game.grid[4], :marked?).from(false).to(true)
			end
		end

		context "when center is available" do
			it "ignores any other weaker moves" do
				is_expected.not_to receive(:escape)
			end

			it "marks center cell" do
				expect { subject.turn }.to change(game.grid[5], :marked?).from(false).to(true)
			end	
		end

		context "when center is marked by player and opponent has marked each opposite corners" do
			before do 
				game.grid[5].mark("bar")
				[1, 9].each { |c| game.grid[c].mark("foo") }
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:corner)
			end

			it "prevents being trapped by marking a non-corner cell" do
				subject.turn
				expect(game.grid.free_positions).to satisfy do |positions|					
					[2, 4, 6, 8].any? { |c| !positions.include? c } &&
					[3, 7].all? { |c| positions.include? c }
				end
			end

		end

		context "when center is not available and a corner is available" do
			before do
				game.grid[5].mark("foo")				
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:setup)
			end

			it "marks a corner cell" do
				subject.turn
				expect(game.grid.free_positions).to satisfy do |positions|					
						[1, 3, 7, 9].any? { |c| !positions.include? c } &&
						[2, 4, 6, 8].all? { |c| positions.include? c }
				end
			end	
		end

		context "when player has another marked cell in this line" do
			before do
				game.grid[4].mark("foo")
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:random)
			end

			it "marks another cell in the same line" do
				subject.turn
				expect(game.grid.free_positions).to satisfy do |positions|					
						[1, 7, 5, 6].any? { |c| !positions.include? c } &&
						[2, 3, 8, 9].all? { |c| positions.include? c }
				end
			end	
		end

		context "when no other stronger move is available" do
			before do
				[1, 3, 5, 7 ,9].each { |c| game.grid[c].mark("foo") }
			end

			it "marks any available cell" do
				subject.turn
				expect(game.grid.free_positions).to satisfy do |positions|					
					[2, 4, 6, 8].any? { |c| !positions.include? c }					
				end
			end	
		end
	end

end