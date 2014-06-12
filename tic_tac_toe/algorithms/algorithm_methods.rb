module AlgorithmMethods
  O = 'o'
  X = 'x'
  def switch_turn
    @current_turn = current_turn == X ? O : X
  end

  def undo_move(location)
    @dup[location] = '-'
  end

  def game_over?
    check_winner.new(@dup, human_player).win? ||
    check_winner.new(@dup, computer_player).win? ||
    remaining_indices.empty?
  end

  def human_player
    computer_player == O ? X : O
  end

  def new_move(location)
    @dup[location] = current_turn
    @dup
  end

  def remaining_indices
    @dup.each_index.select { |ind| @dup[ind] == '-' }
  end

  def score(depth)
    return (100 - depth) if check_winner.new(@dup, human_player).win?
    return (depth - 100) if check_winner.new(@dup, computer_player).win?
    return 0 if remaining_indices.empty?
  end

  def xturn(value_x, value_o)
    current_turn == human_player ? value_x : value_o
  end
end
