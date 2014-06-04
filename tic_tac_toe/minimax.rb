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
    @dup[location] = current_turn
    @dup
  end

  def minimax(board, depth = 1)
    switch_turn
    return 100 if check_winner.new(@dup, human).win?
    return -100 if check_winner.new(@dup, computer).win?
    return 0 if remaining_indices.empty?

    if current_turn == human
      best_score = -Float::INFINITY
      remaining_indices.each do |move|
        new_board = new_move(move).dup
        score = minimax(new_board, depth + 1) - depth
        undo_move(move)
        if score > best_score
          best_score = score
          @best_move = move
        end
      end
    else
      best_score = Float::INFINITY
      remaining_indices.each do |move|
        new_board = new_move(move).dup
        score = minimax(new_board, depth + 1) + depth
        undo_move(move)
        if score < best_score
          best_score = score
          @best_move = move
        end
      end
    end
    best_score
  end

  def undo_move(location)
    @dup[location] = '-'
    switch_turn
  end

  def minimax_moves
    switch_turn if current_turn == 'x'
    remaining_indices.map do |move|
      new_move(move)
      score = [minimax(board), move]
      undo_move(move)
      score
    end
  end

  def best_move
    #min_or_max = current_turn == 'x' ? :max_by : :min_by
    minimax_moves.send(:min_by) {|a, b| a}[1]
  end

  def computer
    'o'
  end

  def human
    'x'
  end

  def remaining_indices
    @dup.each_index.select { |ind| @dup[ind] == '-' }
  end
end
