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
    max_or_min = nil
    depth_calc = current_turn == human ? -depth : depth
    remaining_indices(boarder).map do |ind|
      new_board = new_move(ind)
      max_or_min = current_turn == human ? :max : :min
      scorer = minimax(new_board, depth + 1) + depth_calc
      undo_move(boarder, ind)
      p "#{scorer}: #{ind}"
      scorer
    end.send(max_or_min)
  end

  def undo_move(boarder, location)
    boarder[location] = '-'
  end

  def best_move
    @top_move
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
