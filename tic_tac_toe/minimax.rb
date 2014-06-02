class MiniMax
  attr_reader :check_winner
  attr_accessor :current_turn, :board

  def initialize(board, check_winner)
    @board = board
    @check_winner = check_winner
    @current_turn = 'x'
  end

  def switch_turn
    @current_turn = @current_turn == 'x' ? 'o' : 'x'
  end

  def move(location)
    board[location] = current_turn
    switch_turn
  end

  def minimax(board, depth = 1)
    return score if check_winner.new(board, current_turn).win? || remaining_indices.empty?
    max_or_min = nil
    remaining_indices.map do |ind|
      move(ind)
      max_or_min = current_turn == human ? :max : :min
      depth_calc = current_turn == human ? depth : -depth
      minimax(board, depth + 1) + depth_calc
    end.send(max_or_min)
  end

  def undo_move(location)
    board[location] = '-'
  end

  def best_move
    remaining_indices.min_by do |ind|
      move ind
      minimax(board)
    end
   #  if current_turn == human
   #    remaining_indices.max_by do |ind|
   #      move ind
   #      m = minimax(board)
   #      undo_move(ind)
   #      m
   #    end
   #  else
   #    remaining_indices.min_by do |ind|
   #      move ind
   #      m = minimax(board)
   #      undo_move(ind)
   #      m
   #    end
   #  end
  end

  def computer
    'o'
  end

  def human
    'x'
  end

  def score
    return 100 if check_winner.new(board, human).win?
    return -100 if check_winner.new(board, computer).win?
    return 0 if remaining_indices.empty?
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end
end
