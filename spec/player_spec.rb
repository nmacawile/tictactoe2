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
			it "marks cell" do
				allow(subject).to receive_message_chain(:gets, :chomp, :to_i) { 9 }
				expect(game).to receive_message_chain(:grid, :[]).with(9) { cell }
				expect(cell).to receive(:mark).with("foo")
			end
		end

		context "when cell index is invalid" do
			it "doesn't mark cell" do
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
				game.grid[2].mark("bar")
				game.grid[3].mark("bar")
				game.grid[4].mark("foo")
				game.grid[6].mark("foo")
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:block)
				is_expected.not_to receive(:center)
				is_expected.not_to receive(:setup)
				is_expected.not_to receive(:random)
			end

			it "marks the winning cell" do			
				expect { subject.turn }.to change(game.grid[1], :marked?).from(false).to(true)
			end

		end

		context "when about to lose" do
			before do
				game.grid[1].mark("foo")
				game.grid[7].mark("foo")
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:center)
				is_expected.not_to receive(:corner)
				is_expected.not_to receive(:setup)
				is_expected.not_to receive(:random)
			end

			it "marks the winning cell" do			
				expect { subject.turn }.to change(game.grid[4], :marked?).from(false).to(true)
			end
		end

		context "when center is available" do
			it "ignores any other weaker moves" do
				is_expected.not_to receive(:corner)
				is_expected.not_to receive(:setup)
				is_expected.not_to receive(:random)
			end

			it "marks center cell" do
				expect { subject.turn }.to change(game.grid[5], :marked?).from(false).to(true)
			end	
		end

		context "when center is not available and a corner is available" do
			before do
				game.grid[5].mark("foo")
				game.grid[7].mark("bar")
				game.grid[9].mark("foo")
				game.grid[3].mark("bar")
			end

			it "ignores any other weaker moves" do
				is_expected.not_to receive(:setup)
				is_expected.not_to receive(:random)
			end

			it "marks a corner cell" do
				expect { subject.turn }.to change(game.grid[1], :marked?).from(false).to(true)
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
					(
						!positions.include?(1) ||
						!positions.include?(7) ||
						!positions.include?(5) ||
						!positions.include?(6)
					) && (
						positions.include?(2) &&
						positions.include?(3) &&
						positions.include?(8) &&
						positions.include?(9))
				end
			end	
		end

		context "when no other stronger move is available" do
			before do
				game.grid[1].mark("foo")
				game.grid[3].mark("foo")
				game.grid[5].mark("foo")
				game.grid[7].mark("foo")
				game.grid[9].mark("foo")
			end

			it "marks any available cell" do
				subject.turn
				expect(game.grid.free_positions).to satisfy do |positions|
					(
						!positions.include?(2) ||
						!positions.include?(4) ||
						!positions.include?(6) ||
						!positions.include?(8)
					)
				end
			end	
		end
	end

end