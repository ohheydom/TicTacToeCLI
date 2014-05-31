class MiniMax
  attr_accessor :check_winner, :choice, :board

  def initialize(board, check_winner)
    @board = board
    @check_winner = check_winner
    @player = 'o'
  end

  def max_score
    scores = minimax(board)
    puts scores
    max_val = scores.values.max
    scores.select { |key, val| val == max_val }
  end

  def best_move
    minimax(board)
    @choice
  end

  def other_player
    @player = @player == 'x' ? 'o' : 'x'
  end

  def switch_player
    @player = @player == 'x' ? 'o' : 'x'
  end

  def minimax(board, depth = 1)
    return score(@player) if check_winner.new(board, @player).win? || depth == 0
    best_val = 0

    if @player == 'o'
      remaining_indices.each do |ind|
        move(ind, @player)
        val = minimax(board, depth - 1)
        if val > best_val
          best_val = val
          @choice = ind
        else
          best_val
        end
      end
    else
      remaining_indices.each do |ind|
        move(ind, @player)
        val = minimax(board, depth - 1)
        if val < best_val
          best_val = val
          @choice = ind
        else
          best_val
        end
      end
    end
    best_val
  end

  def score(player)
    return 100 if check_winner.new(board, @player).win?
    return -100 if check_winner.new(board, other_player).win?
    return 0 if remaining_indices.empty?
  end

  def undo_move(location)
    board[location] = '-'
  end

  def move(location, turn)
    if board[location] == '-'
      board[location] = turn
      location
    else
      nil
    end
    switch_player
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end

  def remaining_indices_count
    remaining_indices.count
  end
end
