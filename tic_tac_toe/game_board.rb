class GameBoard
  attr_accessor :board

  def initialize
    @board = Array.new(9, '-')
  end

  def move(location, turn)
    if board[location] == '-'
      board[location] = turn
      location
    else
      nil
    end
  end

  def display(turn)
    display_turn(turn)
    display_space
    display_board
    display_space
  end

  def display_board
    p "  -------  "
    board.each_slice(3) { |slice| p " | #{slice.join(" ")} | " }
    p "  -------  "
  end
  
  def display_turn(turn)
    p "Current player: #{turn}"
  end

  def display_space
    puts "\n"
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end

  def remaining_indices_count
    remaining_indices.count
  end
end
