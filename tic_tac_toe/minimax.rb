class MiniMax
  attr_reader :check_winner
  attr_accessor :current_turn, :board

  def initialize(board, check_winner)
    @board = board
    @dup = board.dup
    @check_winner = check_winner
    @current_turn = 'x'
  end

  def switch_turn
    @current_turn = @current_turn == 'x' ? 'o' : 'x'
  end

  def new_move(location)
    x = @dup
    x[location] = current_turn
    switch_turn
    x
  end

  def win?(boarder)
    check_winner.new(boarder, 'x').win? || check_winner.new(boarder, 'o').win?
  end

  def minimax(boarder, depth = 1)
    return score(boarder) if win?(boarder) || remaining_indices(boarder).empty?
    top_move = nil
    if current_turn == human
      top_score = -Float::INFINITY
    else
      top_score = Float::INFINITY
    end

    remaining_indices(boarder).map do |ind|
      new_board = new_move(ind)
      depth_calc = current_turn == human ? -depth : depth
      score = minimax(new_board, depth + 1) + depth_calc

      if current_turn == human
        if score > top_score
          top_score = score
          top_move = ind
        end
      else
        if score < top_score
          top_score = score
          top_move = ind
        end
        99
      end
    end
    p top_move
    top_score
   #  max_or_min = nil
   #  remaining_indices.map do |ind|
   #    move(ind)
   #    max_or_min = current_turn == human ? :max : :min
   #    depth_calc = current_turn == human ? depth : -depth
   #    minimax(board, depth + 1) + depth_calc
   #  end.send(max_or_min)
  end

  def undo_move(location)
    board[location] = '-'
  end

  def best_move
    remaining_indices(board).min_by do |ind|
      minimax(board)
    end
  end

  def computer
    'o'
  end

  def human
    'x'
  end

  def score(boarder)
    return 100 if check_winner.new(boarder, human).win?
    return -100 if check_winner.new(boarder, computer).win?
    return 0 if remaining_indices(boarder).empty?
  end

  def remaining_indices(boarder)
    boarder.each_index.select { |ind| boarder[ind] == '-' }
  end
end
