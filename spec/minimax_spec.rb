require_relative '../tic_tac_toe/minimax'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'
require_relative '../tic_tac_toe/tic_tac_toe'
require_relative '../tic_tac_toe/computer_ai'


describe MiniMax do
  describe '#minimax' do
    it 'returns 100 if o wins' do
      board = %w(o o o - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      minimax.switch_turn
      expect(minimax.minimax(board)).to eq(100)
    end

    it 'returns -100 if x wins' do
      board = %w(x x x - - - - - -)
      check_winner = CheckWinner
      minimax = MiniMax.new(board, check_winner)
      expect(minimax.minimax(board)).to eq(-100)
    end
  end

  describe '#best_move' do
  end
end
