class MiniMax
  attr_reader :check_winner, :computer_player
  attr_accessor :current_turn, :board
  O = 'o'
  X = 'x'

  def initialize(game_board, computer_player, check_winner)
    @board = game_board.board
    @dup = board.dup
    @check_winner = check_winner
    @current_turn = computer_player
    @computer_player = computer_player
  end

  def switch_turn
    @current_turn = current_turn == X ? O : X
  end

  def new_move(location)
    @dup[location] = current_turn
    @dup
  end

  def minimax_alpha_beta(board, depth = 0, alpha = -Float::INFINITY, beta = Float::INFINITY)
    switch_turn
    return score(depth) if game_over?

    if current_turn == human_player
      remaining_indices.each do |move|
        new_board = new_move(move).dup
        score = minimax_alpha_beta(new_board, depth + 1, alpha, beta) + depth
        undo_move(move)
        switch_turn
        if score > alpha
          @best_move = move
          alpha = score
        end
        return alpha if alpha >= beta
      end
      alpha
    else
      remaining_indices.each do |move|
        new_board = new_move(move).dup
        score = minimax_alpha_beta(new_board, depth + 1, alpha, beta) - depth
        undo_move(move)
        switch_turn
        if score < beta
          @best_move = move
          beta = score
        end
        return beta if alpha >= beta
      end
      beta
    end
  end

  def minimax(board, depth = 0)
    switch_turn
    return score(depth) if game_over?

    best_score = current_turn == human_player ? -Float::INFINITY : Float::INFINITY
    max_or_min = current_turn == human_player ? :max : :min

    remaining_indices.each do |move|
      new_board = new_move(move)
      score = minimax(new_board, depth + 1)
      undo_move(move)
      switch_turn
      if [score, best_score].send(max_or_min) == score
        best_score = score
        @best_move = move
      end
    end
    best_score
  end

  def undo_move(location)
    @dup[location] = '-'
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

  def best_move
    min_or_max = current_turn == human_player ? :max_by : :min_by
    minimax_moves.send(min_or_max) { |score, move| score }[1]
  end

  private

  def game_over?
    check_winner.new(@dup, human_player).win? ||
    check_winner.new(@dup, computer_player).win? ||
    remaining_indices.empty?
  end

  def score(depth)
    return (100 - depth) if check_winner.new(@dup, human_player).win?
    return (depth - 100) if check_winner.new(@dup, computer_player).win?
    return 0 if remaining_indices.empty?
  end

  def human_player
    computer_player == O ? X : O
  end

  def remaining_indices
    @dup.each_index.select { |ind| @dup[ind] == '-' }
  end
end
