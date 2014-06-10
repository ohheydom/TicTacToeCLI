Dir[File.join(__dir__, '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'algorithms', '*.rb')].each { |file| require file }

class TicTacToe
  attr_accessor :current_turn, :game_board
  attr_reader :check_winner, :computer_algorithm, :interface
  X = 'x'
  O = 'o'

  def initialize(args = {})
    args = defaults.merge(args)
    @game_board = args[:game_board]
    @check_winner = args[:check_winner]
    @computer_algorithm = args[:computer_algorithm]
    @interface = args[:interface]
    @current_turn = X
  end

  def board
    game_board.board
  end

  def clear
    game_board.board = game_board.new_board
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

  def play
    interface.play
  end

  private

  def switch_turn
    @current_turn = current_turn == X ? O : X
  end

  def defaults
    { game_board: GameBoard.new,
      check_winner: CheckWinner,
      computer_algorithm: AlphaBetaMinimax,
      interface: CommandLineInterface.new(self) }
  end
end
