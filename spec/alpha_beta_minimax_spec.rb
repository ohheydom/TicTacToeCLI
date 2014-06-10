require_relative '../tic_tac_toe/algorithms/alpha_beta_minimax'
require_relative '../tic_tac_toe/check_winner'

describe AlphaBetaMinimax do
  describe '#alpha_beta_minimax' do
    it 'returns -99 if o can win' do
      board = %w(o - x -
                 - o - -
                 - x - o
                 - x x o)
      game_board = double('GameBoard', board: board)
      check_winner = CheckWinner
      minimax = AlphaBetaMinimax.new(game_board, 'o', check_winner)
      minimax.switch_turn
      expect(minimax.alpha_beta_minimax(board)).to eq(-99)
    end
  end
end
