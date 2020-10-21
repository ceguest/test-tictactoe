class Board 
  attr_accessor :board
  def initialize
    @board = [['_','_','_'],['_','_','_'],['_','_','_']]
  end

  def add_move(column, row, symbol)
    @board[row][column] = symbol
  end
end
