require_relative '../tic_tac_toe/algorithms/else_method'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'

describe ElseMethod do
  describe '#best_move' do
    it 'returns a move that will allow the computer to win' do
      game_board = GameBoard.new
      game_board.board = %w(o o - x x - - - -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.best_move).to eq(2)
    end

    it 'returns a move that will allow the computer to win' do
      game_board = GameBoard.new
      game_board.board = %w(o - - o x - - - x)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.best_move).to eq(6)
    end

    it 'returns a move that will not allow the human player to win' do
      game_board = GameBoard.new
      game_board.board = %w(x x - o - - - o -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.best_move).to eq(2)
    end

    it 'plays the center if the human player did not' do
      game_board = GameBoard.new
      game_board.board = %w(x - - - - - - - -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.best_move).to eq(4)
    end

    it 'plays a corner if the human player played the middle' do
      game_board = GameBoard.new
      game_board.board = %w(- - - - x - - - -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.best_move).to eq(0)
    end
  end

  describe '#fork_position' do
    it 'returns a position if a possible fork is open' do
      game_board = GameBoard.new
      game_board.board = %w(- x - o x x - o -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.fork_position('o')).to eq(6)
    end

    it 'returns a position to block if a possible fork is open' do
      game_board = GameBoard.new
      game_board.board = %w(- - x - - - o x -)
      computer = ElseMethod.new(game_board, 'o', CheckWinner)
      expect(computer.fork_position('x')).to eq(8)
    end
  end
end
