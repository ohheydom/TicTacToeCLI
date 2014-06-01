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
    switch_turn
  end

  def minimax(board, depth = 1)
    return score if check_winner.new(board, current_turn).win? #|| depth == 0
    # best_val = 0

    # if @player == 'o'
    #   remaining_indices.each do |ind|
    #     val = minimax(board, depth - 1)
    #     if val > best_val
    #       best_val = val
    #       @choice = ind
    #     else
    #       best_val
    #     end
    #   end
    # else
    #   remaining_indices.each do |ind|
    #     val = minimax(board, depth - 1)
    #     if val < best_val
    #       best_val = val
    #       @choice = ind
    #     else
    #       best_val
    #     end
    #   end
    # end
    # best_val
  end

  def computer
    'o'
  end

  def human
    'x'
  end

  def score
    return 100 if check_winner.new(board, computer).win?
    return -100 if check_winner.new(board, human).win?
    return 0 if remaining_indices.empty?
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end

  def remaining_indices_count
    remaining_indices.count
  end
end
