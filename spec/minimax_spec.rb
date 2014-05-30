require_relative '../tic_tac_toe/minimax'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'

describe MiniMax do
  describe '#max_score' do
    it 'returns a hash of highest score with the corresponding move' do
      board = GameBoard.new
      check_winner = CheckWinner
      board.board = %w(x - -
                       - x o
                       - o -)
      expect(MiniMax.new(board, check_winner).max_score).to eq(8 => 100)
    end
  end

  describe '#hash_of_scores' do
    it 'returns a hash of all scores which correspond to the remaining moves' do
      board = GameBoard.new
      check_winner = CheckWinner
      board.board = %w(x x o
                       - x o
                       - o -)
      expect(MiniMax.new(board, check_winner).hash_of_scores('x')).to eq(3 => 0, 6 => 0, 8 => 100)

    end
  end
end
