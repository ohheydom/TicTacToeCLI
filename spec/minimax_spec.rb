require_relative '../tic_tac_toe/minimax'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'
require_relative '../tic_tac_toe/tic_tac_toe'
require_relative '../tic_tac_toe/computer_ai'


describe MiniMax do
  describe '#minimax' do
    it 'returns -100 if o wins' do
      board = %w(o o o - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.minimax(board)).to eq(-100)
    end

    it 'returns 100 if x wins' do
      board = %w(x x x - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.minimax(board)).to eq(100)
    end

    it 'returns 0 if nobody wins' do
      board = %w(x o x o x o o x o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.minimax(board)).to eq(0)
    end

    it 'returns 99 if x can win' do
      board = %w(x x - - - - - - o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.minimax(board)).to eq(99)
    end

    it 'returns -99 if o can win' do
      board = %w(x x - o o x o x o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.minimax(board)).to eq(-99)
    end
  end

  describe '#best_move' do
    it 'returns the location for a winning move' do
      board = %w(- - - x x - - o o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.best_move).to eq(5)
    end

    it 'blocks the location of a winning move' do
      board = %w(o - - x - x - o -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.best_move).to eq(4)
    end
  end
end
