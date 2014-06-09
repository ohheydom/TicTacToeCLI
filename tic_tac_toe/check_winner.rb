class CheckWinner
  attr_reader :turn, :board

  def initialize(board, turn)
    @dimension = Math.sqrt(board.size)
    @board = board.each_slice(@dimension).to_a
    @turn = turn
  end

  def win?
    horizontal_win? || vertical_win? || diagonal_win?
  end

  private

  def horizontal_win?
    board.any? { |row| row.all? { |val| val == turn } }
  end

  def vertical_win?
    board.transpose.any? { |row| row.all? { |val| val == turn } }
  end

  def diagonal_win?
    board.map.with_index.all? { |row, ind| row[ind] == turn } ||
    board.map.with_index.all? { |row, ind| row[@dimension - 1 - ind] == turn }
  end
end
