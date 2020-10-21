class MinimaxComputer
    attr_accessor :board_checker

    def initialize(board_checker)
        @board_checker = board_checker
    end

    def move(board)
        current_board = board.board

        return minimax(current_board)[1]
    end

    def possible_moves(board)
        available_moves = []

        board.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if symbol == "_"
                    available_moves << [column_index, row_index]
                end
            end
        end
        
        return available_moves
    end
    
    def score_board(board)
        return 1 if @board_checker.three_in_a_line?(board, "X")
        return -1 if @board_checker.three_in_a_line?(board, "O")
        0
    end

    private

    def game_over?(board)
        @board_checker.three_in_a_line?(board, 'X') == true or 
        @board_checker.three_in_a_line?(board, 'O') == true or
        @board_checker.full_board?(board) == true
    end

    def get_symbol(board_array)
        if board_array.flatten.count('_') % 2 == 1
            return 'X'
        end
        'O'
    end

    def minimax(board_array)
        symbol = get_symbol(board_array)
        available_moves = possible_moves(board_array)
        scores_hash = {}
        available_moves.each do |move| 
            new_board = Board.new
            new_board.board = board_array.map(&:dup)
            new_board.add_move(move[0], move[1], symbol)

            if not game_over?(new_board.board)
                score = minimax(new_board.board)[0]
                scores_hash.merge!(move => score)
            else 
                score = score_board(new_board.board)
                scores_hash.merge!(move => score)
            end
        end

        if symbol == 'X' 
            return [scores_hash.values.max, scores_hash.key(scores_hash.values.max)]
        end
        return [scores_hash.values.min, scores_hash.key(scores_hash.values.min)]
    end

end
