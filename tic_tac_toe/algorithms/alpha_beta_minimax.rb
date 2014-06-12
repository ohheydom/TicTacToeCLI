require_relative 'algorithm_methods'

class AlphaBetaMinimax
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

  def alpha_beta_minimax(board, depth = 0, alpha = -Float::INFINITY, beta = Float::INFINITY)
    switch_turn
    return score(depth) if game_over?

    remaining_indices.each do |move|
      new_board = new_move(move)
      score = alpha_beta_minimax(new_board, depth + 1, alpha, beta)
      undo_move(move)
      switch_turn
      alpha = score if score > alpha && current_turn == human_player
      beta = score if score < beta && current_turn == computer_player
      return xturn(alpha, beta) if alpha >= beta
    end
    xturn(alpha, beta)
  end

  def best_move
    minimax_moves.send(xturn(:max_by, :min_by)) { |score, move| score }[1]
  end

  def minimax_moves
    remaining_indices.map do |move|
      new_move(move)
      score = [alpha_beta_minimax(board), move]
      undo_move(move)
      switch_turn
      score
    end
  end
end
