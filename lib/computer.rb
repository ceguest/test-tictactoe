class Computer
  def move(board)
    (0..2).each do |row|
        (0..2).each do |column|
            if board.board[row][column] == "_"
                return [column, row]
            end
        end        
    end
  end
end