require 'score_game'
require 'rspec'

describe "#score" do
  context 'handles improper inputs' do
    it "returns 0 for an empty array" do
      game = []

      expect(score(game)).to eq(0)
    end

    it "returns 'invalid' for non array inputs" do
      game = "bad"

      expect(score(game)).to eq("invalid")
    end

    it "returns 'invalid' for non-integer sub arrays" do
      game = [["bad", 1], [10, 0]]

      expect(score(game)).to eq("invalid")
    end
  end

  context 'properly scores a game' do
    it "handles incomplete games" do
      game = [[2, 3], [3, 4], [7, 2]]

      expect(score(game)).to eq(21)
    end

    it "handles games with strikes" do
      game = [[10, 0], [10, 0], [10, 0]]

      expect(score(game)).to eq(60)
    end

    it "handles games with spares" do
      game = [[8, 2], [3, 4]]

      expect(score(game)).to eq(20)
    end

    it "handles a game with a spare in the tenth frame" do
      game = [[10, 0]] * 9 + [[6, 4, 10]]

      expect(score(game)).to eq(276)
    end

    it "returns 300 for a perfect game" do
      game = [[10, 0]] * 9 + [[10, 10, 10]]

      expect(score(game)).to eq(300)
    end
  end
end
