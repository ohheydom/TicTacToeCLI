require_relative '../tic_tac_toe/minimax'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'
require_relative '../tic_tac_toe/tic_tac_toe'
require_relative '../tic_tac_toe/computer_ai'

describe MiniMax do
  describe '#newmove' do
    it 'returns a copy of the new board' do
      board = %w(- - o - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.new_move(0)
      minimax.switch_turn
      minimax.new_move(3)
      minimax.switch_turn
      minimax.new_move(4)
      minimax.switch_turn
      expect(minimax.new_move(5)).to eq(%w(x - o o x o - - -))
    end

    it 'does not change the original board' do
      board = %w(- - o - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.new_move(0)
      minimax.new_move(3)
      minimax.new_move(4)
      expect(minimax.board).to eq(%w(- - o - - - - - -))
    end
  end

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
      board = %w(x o - x x - - o o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.minimax(board)).to eq(99)
    end

    it 'returns -99 if o can win' do
      board = %w(o o -
                 - x - 
                 x - x)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.minimax(board)).to eq(-99)
    end
  end

  describe '#best_move' do
    it 'returns the location for a winning move for x' do
      board = %w(- o x
                 x x -
                 o o -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.best_move).to eq(5)
    end

    it 'returns the location for a winning move for x' do
      board = %w(- - o
                 - x - 
                 - x o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.best_move).to eq(1)
    end

    it 'returns the location for a winning move for o' do
      board = %w(- - o
                 - - - 
                 x x o)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.current_turn = 'o'
      expect(minimax.best_move).to eq(5)
    end

    it 'o blocks the location of a winning move' do
      board = %w(o - -
                 x - x
                 o - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.best_move).to eq(4)
    end

    it 'o blocks the location of a winning move' do
      board = %w(x - x
                 - o -
                 o x -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.current_turn = 'o'
      expect(minimax.best_move).to eq(1)
    end

    it 'o puts a mark in the the center if a corner is played' do
      board = %w(x - -
                 - - -
                 - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.current_turn = 'o'
      expect(minimax.best_move).to eq(4)
    end
  end
end
