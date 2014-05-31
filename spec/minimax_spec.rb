require_relative '../tic_tac_toe/minimax'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'

describe MiniMax do
  describe '#max_score' do
    it 'returns a hash of highest score with the corresponding move' do
      check_winner = CheckWinner
      board = %w(x - -
                 - x o
                 - o -)
      expect(MiniMax.new(board, check_winner).max_score).to eq(8 => 100)
    end
  end

  describe '#minimax' do
    it 'returns 100 if the computer can win' do
      check_winner = CheckWinner
      board = %w(- x o
                 - o x
                 - o x)
      expect(MiniMax.new(board, check_winner).minimax(board)).to eq(100)
    end

    it 'returns -100 if human can win' do
      check_winner = CheckWinner
      board = %w(o x o
                 - o x
                 - o x)
      expect(MiniMax.new(board, check_winner).minimax(board)).to eq(-100)
    end
  end

  describe '#best_move' do
    it 'blah' do
      check_winner = CheckWinner
      board = %w(o x -
                 x o -
                 x o -)
      expect(MiniMax.new(board, check_winner).best_move).to eq(8)
    end
  end
end
