require "sinatra"
require "erb"
require_relative "lib/game_controller"
require_relative "lib/computer"
require_relative "lib/board"
require_relative "lib/board_checker"
require_relative "lib/minimax_computer"


def interpret_input(coordinates)
    letter_coords = { 'A' => 0, 'B' => 1, 'C' => 2}
    return [letter_coords[coordinates[0]], coordinates[1].to_i - 1]
end

def interpret_board_array(gridref, board_array)
    numerical_coordinates = interpret_input(gridref.to_s)

    return board_array[numerical_coordinates[1]][numerical_coordinates[0]]
end

def return_message_if_over(game_controller)
    game_status = game_controller.get_game_status
    if game_status != 'pending'
        return 'Game is drawn, there are no more moves!' if game_status == "drawn"
        return 'CONGRATULATIONS!!! You beat our very advanced AI!!' if game_status == "X win"
        return "UNLUCKY!!! Our very advanced AI outsmarted you!!" if game_status == "O win"
    end
    return ""
end

#https://github.com/webdevjeffus/css-for-sinatra
configure do
    enable :sessions
end


get "/ttt" do
    @A1 = session[:A1]
    @A2 = session[:A2]
    @A3 = session[:A3]
    @B1 = session[:B1]
    @B2 = session[:B2]
    @B3 = session[:B3]
    @C1 = session[:C1]
    @C2 = session[:C2]
    @C3 = session[:C3]

    @message = session[:message]
    comp = session[:game_controller]

    erb :tic_tac_toe
end

post "/ttt" do

    if session[:game_controller] == nil or params[:new_easy] == "reset" or params[:new_hard] == "reset"
        board = Board.new

        if params[:new_easy] == "reset"
            computer = Computer.new
        else
            computer = MinimaxComputer.new(BoardChecker.new)
        end

        game_controller = GameController.new(board, computer)
        game_controller.add_board_checker(BoardChecker.new)

        session[:game_controller] = game_controller

        session[:message] = ""
    end

    locations = [:A1, :A2, :A3,
                 :B1, :B2, :B3,
                 :C1, :C2, :C3]
                 
    if session[:message] == ""
        locations.each do |loc|
            if params[loc] != nil and session[loc] != 'O' and session[loc] != 'X'
                session[loc] = params[loc]
                coordinate_array = interpret_input(loc.to_s)
                session[:game_controller].move(coordinate_array[0],coordinate_array[1])

                
                session[:message] = return_message_if_over(session[:game_controller])
                m = session[:message]
                puts 'hello'
                if session[:game_controller].turn <9 and session[:message] == ""
                    session[:game_controller].run_ai
                end 

                session[:message] = return_message_if_over(session[:game_controller])
                n = session[:message]
            end
        end
    end

    o = session[:message]

    locations.each do |loc|
        boardstate = session[:game_controller].get_boardstate
        symbol = interpret_board_array(loc, boardstate)
        session[loc] = symbol
        session[loc] = "" if symbol == "_"
    end

    redirect "/ttt"
end