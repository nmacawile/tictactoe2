require 'grid'

describe TicTacToe::Grid do
	subject { TicTacToe::Grid.new }

	describe "#win?" do
		context "when a line has three of the same symbol" do
			it "returns true" do
				[1, 2, 3].each { |c| subject[c].mark("foo") }
				expect(subject.win?("foo")).to be true
				expect(subject.win?("bar")).to be false
			end
		end

		context "when a line doesn't have three of the same symbol" do
			it "returns false" do
				[1, 3].each { |c| subject[c].mark("foo") }
				subject[2].mark("bar")
				expect(subject.win?("foo")).to be false
				expect(subject.win?("bar")).to be false
			end
		end
	end

	describe "#full?" do
		context "when the grid is full" do
			it "returns true" do
				[1, 2, 3, 4, 5, 6, 7, 8, 9].each { |c| subject[c].mark("foo") }
				expect(subject.full?).to be true
			end
		end

		context "when the grid is not full" do
			it "returns false" do
				[1, 2, 3, 4, 5, 6, 7, 8].each { |c| subject[c].mark("foo") }
				expect(subject.full?).to be false
			end
		end
	end

	describe "#free_positions" do
		it "returns an array with all the free positions" do
			[1, 3, 5, 7, 9].each { |c| subject[c].mark("foo") }
			expect(subject.free_positions).to include(2, 4, 6, 8)
		end
	end
end