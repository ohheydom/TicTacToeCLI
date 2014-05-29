require_relative 'computer_ai'
require_relative 'game_board'
require_relative 'check_winner'
require_relative 'tic_tac_toe'

TicTacToe.new(GameBoard.new, CheckWinner, ComputerAI).play
