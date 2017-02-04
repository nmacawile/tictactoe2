require 'player'

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