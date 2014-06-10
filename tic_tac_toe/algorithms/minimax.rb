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

  def best_move
    minimax_moves.send(xturn(:max_by, :min_by)) { |score, move| score }[1]
  end

  def new_move(location)
    @dup[location] = current_turn
    @dup
  end

  def minimax(board, depth = 0)
    switch_turn
    return score(depth) if game_over?

    best_score = xturn(-Float::INFINITY, Float::INFINITY)

    remaining_indices.each do |move|
      new_board = new_move(move)
      score = minimax(new_board, depth + 1)
      undo_move(move)
      switch_turn
      best_score = score if [score, best_score].send(xturn(:max, :min)) == score
    end
    best_score
  end

  def switch_turn
    @current_turn = current_turn == X ? O : X
  end

  def undo_move(location)
    @dup[location] = '-'
  end

  private

  def game_over?
    check_winner.new(@dup, human_player).win? ||
    check_winner.new(@dup, computer_player).win? ||
    remaining_indices.empty?
  end

  def human_player
    computer_player == O ? X : O
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
