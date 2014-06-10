require_relative '../tic_tac_toe/algorithms/negamax'
require_relative '../tic_tac_toe/check_winner'

describe Negamax do
  describe '#negamax' do
    it 'returns 100 if x wins' do
      board = %w(x x x - - - - - -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      expect(negamax.negamax(board)).to eq(100)
    end

    it 'returns -100 if o wins' do
      board = %w(o o o - - - - - -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      expect(negamax.negamax(board)).to eq(-100)
    end

    it 'returns 0 if nobody wins' do
      board = %w(x o x o x o o x o)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      expect(negamax.negamax(board)).to eq(0)
    end

    it 'returns 99 if x can win' do
      board = %w(x - x - o - o - -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      expect(negamax.negamax(board)).to eq(99)
    end

    it 'returns -99 if o can win' do
      board = %w(o - o - x - x - -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      negamax.switch_turn
      expect(negamax.negamax(board)).to eq(-99)
    end
  end

  describe '#best_move' do
    it 'returns the location for a winning move for x' do
      board = %w(x - -
                 x - o
                 - o -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      expect(negamax.best_move).to eq(6)
    end

    it 'returns the location for a winning move for o' do
      board = %w(- - x
                 o - o
                 - x -)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      negamax = Negamax.new(game_board, 'o', check_winner)
      negamax.switch_turn
      expect(negamax.best_move).to eq(4)
    end
  end
end
