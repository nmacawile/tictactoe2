require "cell"
require "colorize"

describe TicTacToe::Cell do

	let(:cell) { TicTacToe::Cell.new(2) }
	
	
	context "when cell is empty" do
		describe "#free?" do
			it "returns 'true'" do
				expect(cell.free?).to be true
			end
		end

		describe "#marked?" do
			it "returns 'false'" do
				expect(cell.marked?).to be false
			end
		end

		describe "#mark(symbol)" do
			it "marks the cell" do
				expect { cell.mark("foo") }.to change(cell, :value).from(nil).to("foo")
			end

			it "returns true" do
				expect(cell.mark("foo")).to be true
			end
		end

		describe "#to_s" do
			it "returns its index as a colorized string" do
				expect(cell.to_s).to eq("2".colorize(:light_black))
			end
		end
	end
	context "when cell is marked" do
		before { cell.mark("bar") }

		describe "#free?" do
			it "returns 'false'" do
				expect(cell.free?).to be false
			end
		end

		describe "#marked?" do
			it "returns 'true'" do
				expect(cell.marked?).to be true
			end
		end

		describe "#mark(symbol)" do
			it "does not mark the cell" do				
				expect(cell.value).to eq("bar")
				cell.mark("foo")
			end

			it "returns false" do
				expect(cell.mark("foo")).to be false
			end
		end

		describe "#to_s" do
			it "returns its value as a string" do
				expect(cell.to_s).to eq("bar")
			end
		end

	end
	
end