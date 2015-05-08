require_relative 'forks'

class ElseMethod
  include Forks
  attr_reader :game_board, :turn, :check_winner, :old_board
  CORNERS = [0, 2, 6, 8]
  SIDES = [3, 1, 5, 7]
  X = 'x'
  O = 'o'

  def initialize(game_board, turn, check_winner)
    @game_board = game_board
    @old_board = game_board.board.dup
    @turn = turn
    @check_winner = check_winner
  end

  def human_player
    turn == O ? X : O
  end

  def best_move
    play_to_win || play_to_stop_human_win || play_fork(turn) || block_fork(human_player) || play_center || play_corner || play_side || 0
  end

  def board
    game_board.board
  end

  private

  def play_fork(player)
    fork_pos = fork_position(player)
    return nil unless fork_pos
    move = game_board.move(fork_pos, turn) ? fork_pos : nil
    rollback_board
    move
  end

  def play_to_win
    winning_move = game_board.remaining_indices.select do |move|
      game_board.move(move, turn)
      win = check_winner.new(board, turn).win?
      rollback_board
      win
    end
    winning_move.empty? ? nil : winning_move.first
  end

  def play_to_stop_human_win
    stop_human_move = game_board.remaining_indices.select do |move|
      game_board.move(move, human_player)
      win = check_winner.new(board, human_player).win?
      rollback_board
      win
    end
    stop_human_move.empty? ? nil : stop_human_move.first
  end

  def play_center
    move = game_board.move(4, turn) ? 4 : nil
    rollback_board
    move
  end

  def play_corner
    move = CORNERS.find { |ind| game_board.move(ind, turn) }
    rollback_board
    move
  end

  def play_side
    move = SIDES.find { |ind| game_board.move(ind, turn) }
    rollback_board
    move
  end

  def rollback_board
    game_board.board = old_board.dup
  end

  alias_method :block_fork, :play_fork
end
