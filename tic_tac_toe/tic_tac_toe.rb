require_relative 'command_line_interface'
Dir[File.join(__dir__, 'algorithms', '*.rb')].each { |file| require_relative file }

class TicTacToe
  attr_accessor :current_turn, :game_board
  attr_reader :check_winner, :computer_algorithm
  include CommandLineInterface
  X = 'x'
  O = 'o'

  def initialize(game_board = GameBoard.new, check_winner = CheckWinner, computer_algorithm = MiniMax)
    @game_board = game_board
    @check_winner = check_winner
    @computer_algorithm = computer_algorithm
    @current_turn = X
  end

  def board
    game_board.board
  end

  def clear
    game_board.board = Array.new(9, '-')
    @current_turn = X
  end

  def computer_move
    computer_algorithm.new(game_board, O, check_winner).best_move
  end

  def move(location)
    switch_turn if game_board.move(location, current_turn)
    board
  end

  def remaining_moves_count
    game_board.remaining_indices_count
  end

  def remaining_moves
    game_board.remaining_indices
  end

  def previous_turn
    current_turn == X ? O : X
  end

  def win?(turn = previous_turn)
    check_winner.new(board, turn).win?
  end

  private

  def switch_turn
    @current_turn = current_turn == X ? O : X
  end
end
