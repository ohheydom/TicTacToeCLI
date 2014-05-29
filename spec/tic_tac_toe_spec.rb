require_relative '../tic_tac_toe/tic_tac_toe'
require_relative '../tic_tac_toe/game_board'
require_relative '../tic_tac_toe/check_winner'
require_relative '../tic_tac_toe/computer_ai'

describe TicTacToe do
  before do
    gameboard = GameBoard.new
    check_winner = CheckWinner
    computer = ComputerAI
    @game = TicTacToe.new(gameboard, check_winner, computer)
  end

  describe '#board' do
    it 'returns an array of 9 dashes upon initial instantiation' do
      expect(@game.board).to eq(Array.new(9, '-'))
    end
  end

  describe '#move' do
    it 'returns %w(x - - - - - - - -) when move(0) is called' do
      @game.move(0)
      expect(@game.board).to eq(%w(x - - - - - - - -))
    end

    it 'returns %w(x o - - - - - - -) when move(0) then move(1) is called' do
      @game.move(0)
      @game.move(1)
      expect(@game.board).to eq(%w(x o - - - - - - -))
    end

    it 'returns the same board if a location has already been used' do
      @game.move(0)
      expect(@game.board).to eq(%w(x - - - - - - - -))
    end
  end

  describe '#win' do
    it 'returns true when x wins' do
      game_board = double('GameBoard', board: %w(x x x o - o o - -))
      game = TicTacToe.new(game_board, CheckWinner, ComputerAI)
      expect(game.win?('x')).to eq(true)
    end

    it 'returns true when o wins' do
      game_board = double('GameBoard', board: %w(o x x o - o o x -))
      game = TicTacToe.new(game_board, CheckWinner, ComputerAI)
      game.current_turn = 'o'
      expect(game.win?('o')).to eq(true)
    end
  end

  describe '#clear' do
    it 'resets the game board and sets the current_user to x' do
      game_board = GameBoard.new
      game_board.board = %w(o x x o - o o x -)
      game = TicTacToe.new(game_board, CheckWinner, ComputerAI)
      expect(game.board).to eq(%w(o x x o - o o x -))
      game.clear
      expect(game.board).to eq(%w(- - - - - - - - -))
    end
  end

  describe '#computer_move' do
    it 'returns a move that will allow the computer to win' do
      game_board = GameBoard.new
      game_board.board = %w(o o - x x - - - -)
      game = TicTacToe.new(game_board, CheckWinner, ComputerAI)
      expect(game.computer_move).to eq(2)
    end
  end
end
