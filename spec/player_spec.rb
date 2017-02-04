require 'player'

describe TicTacToe::HumanPlayer do
	let(:game) { double }

	subject { 
		TicTacToe::HumanPlayer.new(game, "playername", "foo") 
	}

	describe "#turn" do

		let(:index) { double }

		before do			
			is_expected.to receive(:loop).and_yield
			is_expected.to receive(:print)
			is_expected.to receive_message_chain(:gets, :chomp, :to_i) { index }
		end

		after do
			subject.turn
		end

		context "when cell is already marked" do
			it "doesn't mark cell" do			
				is_expected.to receive(:puts).with(/Invalid/)
				expect(index).to receive(:between?).and_return(true)
				cell = double
				expect(game).to receive_message_chain(:grid, :[]).with(index) { cell }
				expect(cell).to receive(:mark).with("foo").and_return(false)
			end
		end

		context "when cell index is invalid" do
			it "doesn't mark cell" do
				is_expected.to receive(:puts).with(/Invalid/)
				expect(index).to receive(:between?).and_return(false)
			end
		end

		context "when cell is empty" do
			it "marks cell" do
				is_expected.not_to receive(:puts).with(/Invalid/)
				expect(index).to receive(:between?).and_return(true)				
				cell = double
				expect(game).to receive_message_chain(:grid, :[]).with(index) { cell }
				expect(cell).to receive(:mark).with("foo").and_return(true)
			end
		end		
	end
end

describe TicTacToe::ComputerPlayer do
	context "when about to win" do
	
	end

	context "when about to lose" do
	
	end

	context "when center is available" do

	end

	context "when center is not avalable and a corner is available" do

	end

	context "when player has another marked cell in this line" do

	end

	context "when no other strong move is available" do

	end

end