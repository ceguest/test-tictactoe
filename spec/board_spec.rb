require 'board'

describe Board do
  context 'initialize board' do
    it 'create @board as an empty board array' do
      expect(described_class.new.board).to eq([['_','_','_'],['_','_','_'],['_','_','_']])
    end
  end

  context "add move" do
    it "updates the state of the board to reflect the move" do
      board = described_class.new
      board.add_move(0,0,'X')
      expect(board.board).to eq([['X','_','_'],['_','_','_'],['_','_','_']])
    end
    it "updates the state of the board to reflect a different move" do
      board = described_class.new
      board.add_move(0,1,'O')
      expect(board.board).to eq([['_','_','_'],['O','_','_'],['_','_','_']])
    end
  end
end