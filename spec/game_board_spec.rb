require_relative '../tic_tac_toe/game_board'

describe GameBoard do
  describe '#new' do
    it 'instantiates an array of 9 dashes' do
      expect(GameBoard.new.board).to eq(Array.new(9, '-'))
    end
  end

  describe '#move' do
    it 'returns the location if the move is valid' do
      game = GameBoard.new
      expect(game.move(0, 'x')).to eq(0)
    end

    it 'returns the nil if the move is valid' do
      game = GameBoard.new
      game.board = %w(x - - - - - - - -)
      expect(game.move(0, 'o')).to eq(nil)
    end
  end

  describe '#remaining_indices' do
    it 'returns the remaining available locations for a move' do
      game = GameBoard.new
      game.move(0, 'x')
      game.move(1, 'o')
      game.move(8, 'x')
      expect(game.remaining_indices).to eq([2, 3, 4, 5, 6, 7])
    end
  end
end
