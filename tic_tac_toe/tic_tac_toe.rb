require_relative 'constants'

class TicTacToe
  attr_accessor :current_turn, :game_board
  attr_reader :check_winner, :computer_ai
  include Constants

  def initialize(game_board = GameBoard.new, check_winner = CheckWinner, computer_ai = ComputerAI)
    @game_board = game_board
    @check_winner = check_winner
    @computer_ai = computer_ai
    @current_turn = X
  end

  def play
    p "Let's get started!"
    puts "\n"
    display_board
    while win? == false
      p "Available moves: #{remaining_moves.join ', '}"
      p 'Make your move'
      if current_turn == X
        player_move = gets
        move(player_move.to_i)
      else
        move(computer_move)
      end
      break if remaining_moves_count == 0
    end
    if win?
      p "Congratulations #{previous_turn}"
    else
      p 'Draw!'
    end
    play_again
  end

  def play_again
    p 'Play Again?'
    answer = gets.chomp.downcase
    if YES.include?(answer)
      clear
      play
    else
      clear
      return
    end
  end

  def board
    game_board.board
  end

  def clear
    game_board.board = Array.new(9, '-')
    @current_turn = X
  end

  def computer_move
    computer_ai.new(game_board, O, check_winner).best_move
  end

  def display_board
    game_board.display(current_turn)
  end

  def move(location)
    switch_turn if game_board.move(location, current_turn)
    display_board
  end

  def remaining_moves_count
    game_board.remaining_indices_count
  end

  def remaining_moves
    game_board.remaining_indices
  end

  def previous_turn
    current_turn == X ? O : X
  end

  def win?(turn = previous_turn)
    check_winner.new(board, turn).win?
  end

  private

  def switch_turn
    @current_turn = current_turn == X ? O : X
  end
end
