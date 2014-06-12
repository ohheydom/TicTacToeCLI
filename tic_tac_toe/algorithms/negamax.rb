require_relative 'algorithm_methods'

class Negamax
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

  def negamax(board, depth = 0, color = 1)
    switch_turn
    @result ||= {}

    return @result[board] if @result[board]
    return score(depth) * color if game_over?

    best_score = -Float::INFINITY
    remaining_indices.each do |move|
      new_board = new_move(move)
      score = -negamax(new_board, depth + 1, xturn(-color, color))
      undo_move(move)
      switch_turn
      best_score = [best_score, score].max
      @result[new_board] = xturn(best_score, -best_score)
    end
    xturn(best_score, -best_score)
  end

  def best_move
    negamax_moves.send(xturn(:max_by, :min_by)) { |score, move| score }[1]
  end

  def negamax_moves
    remaining_indices.map do |move|
      new_move(move)
      score = [negamax(board), move]
      undo_move(move)
      switch_turn
      score
    end
  end
end
