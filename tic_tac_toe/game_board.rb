class GameBoard
  attr_accessor :board
  attr_reader :size

  def initialize(size = 3)
    @size = size
    @board = create_board(size)
  end

  def move(location, turn)
    if board[location] == '-'
      board[location] = turn
      location
    else
      nil
    end
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end

  def remaining_indices_count
    remaining_indices.count
  end

  def new_board
    create_board(size)
  end

  private

  def create_board(size)
    Array.new(size**2, '-')
  end
end
