class MiniMax
  attr_reader :game_board, :old_board
  attr_accessor :check_winner

  def initialize(game_board, check_winner)
    @game_board = game_board
    @check_winner = check_winner
    @old_board = game_board.board.dup
  end

  def board
    game_board.board
  end

  def max_score
    scores = hash_of_scores('x')
    max_val = scores.keys.max
    scores.select { |(key, val)| key == max_val }
  end

  def best_move
    max_score.keys.first
  end

  def other_player
    'o'
  end

  def hash_of_scores(player)
    scores = {}
    game_board.remaining_indices.each do |move|
      game_board.move(move, player)
      if check_winner.new(board, player).win?
        scores[move] = 100
      elsif check_winner.new(board, other_player).win?
        scores[move] = -100
      else
        scores[move] = 0
      end
      rollback_board
    end
    scores
  end

  def rollback_board
    game_board.board = old_board.dup
  end
end
