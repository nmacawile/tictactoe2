require "cell"
require "colorize"

describe TicTacToe::Cell do

	subject { TicTacToe::Cell.new(2) }
	
	
	context "when cell is empty" do
		describe "#free?" do
			it "returns 'true'" do
				expect(subject.free?).to be true
			end
		end

		describe "#marked?" do
			it "returns 'false'" do
				expect(subject.marked?).to be false
			end
		end

		describe "#mark(symbol)" do
			it "marks the cell" do
				expect { subject.mark("foo") }.to change(subject, :value).from(nil).to("foo")
			end

			it "returns true" do
				expect(subject.mark("foo")).to be true
			end
		end

		describe "#to_s" do
			it "returns its index as a colorized string" do
				expect(subject.to_s).to eq("2".colorize(:light_black))
			end
		end
	end
	context "when cell is marked" do
		before { subject.mark("bar") }

		describe "#free?" do
			it "returns 'false'" do
				expect(subject.free?).to be false
			end
		end

		describe "#marked?" do
			it "returns 'true'" do
				expect(subject.marked?).to be true
			end
		end

		describe "#mark(symbol)" do
			it "does not mark the cell" do				
				expect(subject.value).to eq("bar")
				subject.mark("foo")
			end

			it "returns false" do
				expect(subject.mark("foo")).to be false
			end
		end

		describe "#to_s" do
			it "returns its value as a string" do
				expect(subject.to_s).to eq("bar")
			end
		end

	end
	
end