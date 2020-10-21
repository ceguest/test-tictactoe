class BoardChecker 

    def full_board?(current_board)
        return false if current_board.flatten.include?('_')
        true
    end

    def three_in_a_line?(current_board, symbol)
        return true if three_in_a_row?(current_board, symbol)
        return true if three_in_a_column?(current_board, symbol)
        return true if three_in_a_diagonal?(current_board, symbol)
        false
    end

    def three_in_a_row?(current_board, symbol)
        current_board.each do |row|
            return true if row == [symbol,symbol,symbol]
        end
        false
    end

    def three_in_a_column?(current_board, symbol)
        (0..2).each do |column_index|
            if current_board[0][column_index] == symbol and 
                current_board[1][column_index] == symbol and 
                current_board[2][column_index] == symbol
                return true
            end
        end
        false
    end

    def three_in_a_diagonal?(current_board, symbol)
        if current_board[0][0] == symbol and
            current_board[1][1] == symbol and
            current_board[2][2] == symbol
            return true
        end
        if current_board[0][2] == symbol and
            current_board[1][1] == symbol and
            current_board[2][0] == symbol
            return true
        end
        false
    end
end