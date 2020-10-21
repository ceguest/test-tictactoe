class GameController
    attr_accessor :board, :computer, :turn
    def initialize(board, computer)
        @board = board
        @computer = computer
        @turn = 0
    end

    def add_board_checker(board_checker)
        @board_checker = board_checker
    end

    def move(column, row) 
        sym = 'X'
        sym = 'O' if @turn.odd?
        @turn += 1
        @board.add_move(column, row, sym)
    end

    def get_boardstate
        @board.board
    end

    def run_ai
        coordinates = @computer.move(@board)
        # puts "=============================="
        # p coordinates
        move(coordinates[0], coordinates[1])
    end

    def cell_empty?(column, row)
        current_board = get_boardstate
        if current_board[row][column] == "_"
            return true
        end
        return false
    end

    def get_game_status
        current_board = get_boardstate
        return "X win" if @board_checker.three_in_a_line?(current_board, "X")
        return "O win" if @board_checker.three_in_a_line?(current_board, "O")
        return "drawn" if @board_checker.full_board?(current_board)
        'pending'     
    end
end