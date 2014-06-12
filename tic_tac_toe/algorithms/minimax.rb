require_relative 'algorithm_methods'

class Minimax
  include AlgorithmMethods
  attr_reader :check_winner, :computer_player
  attr_accessor :current_turn, :board

  def initialize(game_board, computer_player, check_winner)
    @board = game_board.board
    @dup = board.dup
    @check_winner = check_winner
    @current_turn = computer_player
    @computer_player = computer_player
  end

  def best_move
    minimax_moves.send(xturn(:max_by, :min_by)) { |score, move| score }[1]
  end

  def minimax(board, depth = 0)
    switch_turn
    @result ||= {}

    return @result[board] if @result[board]
    return score(depth) if game_over?

    best_score ||= xturn(-Float::INFINITY, Float::INFINITY)

    remaining_indices.each do |move|
      new_board = new_move(move)
      score = minimax(new_board, depth + 1)
      undo_move(move)
      switch_turn
      best_score = score if [score, best_score].send(xturn(:max, :min)) == score
      @result[new_board] = best_score
    end
    best_score
  end

  def minimax_moves
    remaining_indices.map do |move|
      new_move(move)
      score = [minimax(board), move]
      undo_move(move)
      switch_turn
      score
    end
  end
end
