require_relative '../tic_tac_toe/check_winner'

describe CheckWinner do
  describe '3X3 board' do
    describe 'horizontal_win?' do
      it 'returns true when player x wins horizontally' do
        board = CheckWinner.new(%w(x x x - - - - - -), 'x')
        expect(board.send(:horizontal_win?)).to be_true
      end

      it 'returns true when player o wins horizontally' do
        board = CheckWinner.new(%w(- - - o o o - - -), 'o')
        expect(board.send(:horizontal_win?)).to be_true
      end
    end

    describe 'vertical_win?' do
      it 'returns true when player x wins vertically' do
        board = CheckWinner.new(%w(x - - x - - x - -), 'x')
        expect(board.send(:vertical_win?)).to be_true
      end

      it 'returns true when player o wins vertically' do
        board = CheckWinner.new(%w(- o - - o - - o -), 'o')
        expect(board.send(:vertical_win?)).to be_true
      end
    end

    describe 'diagonal_win?' do
      it 'returns true when player x wins diagonally' do
        board = CheckWinner.new(%w(x - - - x - - - x), 'x')
        expect(board.send(:diagonal_win?)).to be_true
      end

      it 'returns true when player o wins diagonally' do
        board = CheckWinner.new(%w(- - o - o - o - -), 'o')
        expect(board.send(:diagonal_win?)).to be_true
      end
    end

    describe 'win?' do
      it 'returns true when player x wins horizontally' do
        board = CheckWinner.new(%w(x x x - - - - - -), 'x')
        expect(board.win?).to be_true
      end

      it 'returns true when player x wins vertically' do
        board = CheckWinner.new(%w(x - - x - - x - -), 'x')
        expect(board.win?).to be_true
      end

      it 'returns true when player x wins diagonally' do
        board = CheckWinner.new(%w(x - - - x - - - x), 'x')
        expect(board.win?).to be_true
      end

      it 'returns true when player x wins diagonally' do
        board = CheckWinner.new(%w(- - o - o - o - -), 'o')
        expect(board.win?).to be_true
      end

      it 'returns false when players draw' do
        board = CheckWinner.new(%w(x o x o x o o x o), 'o')
        expect(board.win?).to be_false
      end

      it 'returns false if the turn does not win' do
        board = CheckWinner.new(%w(x o x o x x o - -), 'x')
        expect(board.win?).to be_false
      end
    end
  end

  describe '4X4 board' do
    describe 'horizontal_win?' do
      it 'returns true when player o wins horizontally' do
        board = CheckWinner.new(%w(x - - -
                                   - x - x
                                   o o o o
                                   - - - x), 'o')
        expect(board.send(:horizontal_win?)).to be_true
      end
    end

    describe 'vertical_win?' do
      it 'returns true when player o wins vertically' do
        board = CheckWinner.new(%w(x x - -
                                   - x - x
                                   o x o o
                                   - x - x), 'x')
        expect(board.send(:vertical_win?)).to be_true
      end

      it 'returns false when player o does not win vertically' do
        board = CheckWinner.new(%w(x x - -
                                   - x - x
                                   o x o o
                                   - x - x), 'o')
        expect(board.send(:vertical_win?)).to be_false
      end
    end

    describe 'diagonal_win?' do
      it 'returns true when player o wins diagonally' do
        board = CheckWinner.new(%w(o - - -
                                   - o - -
                                   - - o -
                                   - - - o), 'o')
        expect(board.send(:diagonal_win?)).to be_true
      end
      it 'returns true when player x wins diagonally' do
        board = CheckWinner.new(%w(- - - x
                                   - o x -
                                   - x o -
                                   x - - o), 'x')
        expect(board.send(:diagonal_win?)).to be_true
      end
    end

    describe 'win?' do
      it 'returns false when players draw' do
        board = CheckWinner.new(%w(o x o x
                                   x o x o
                                   o x o x
                                   o x o x), 'x')
        expect(board.send(:win?)).to be_false
      end

      it 'returns true when player o wins' do
        board = CheckWinner.new(%w(o x o x
                                   x o x o
                                   o x o x
                                   o x o o), 'o')
        expect(board.send(:win?)).to be_true
      end
    end
  end
end
