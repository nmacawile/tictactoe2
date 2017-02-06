require 'game'
require 'player'

describe TicTacToe::Game do
	subject do
		TicTacToe::Game.new(TicTacToe::HumanPlayer, "foo", TicTacToe::HumanPlayer, "bar")
	end

	describe "#play" do

		before do 
			allow(subject).to receive(:puts)
			allow(subject).to receive(:print)
			allow(subject).to receive_message_chain(:gets, :chomp, :upcase)
			allow(subject).to receive(:print_board)
			allow(subject).to receive(:loop).and_yield
			allow(subject).to receive(:player_turn)
			allow(subject).to receive(:show_scores)
		end

		context "when game is not yet over" do
			it "switches player after turn" do
				allow(subject).to receive(:over?).and_return(false)
				expect(subject).to receive(:switch_player)
				subject.play
			end
		end

		context "when game is over" do
			context "when a player wins" do
				it "increments the score of the winning player" do
					allow(subject.grid).to receive(:win?).and_return(true)
					expect { subject.play }.to change { subject.current_player.score }.by(1)
				end
			end

			context "when the grid is full" do
				it "increments the draw count" do
					allow(subject.grid).to receive(:full?).and_return(true)
					expect { subject.play }.to change { subject.draws }.by(1)
				end
			end 

			it "doesn't switch player after turn" do
				allow(subject).to receive(:over?).and_return(true)
				expect(subject).not_to receive(:switch_player)
				subject.play
			end
		end
	end

	describe "#switch_player" do
		it "switches player" do
			expect { subject.switch_player }.to change { subject.current_player }
		end
	end


end