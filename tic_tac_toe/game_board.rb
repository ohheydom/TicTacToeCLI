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
    display_board
  end

  def remaining_indices
    board.each_index.select { |ind| board[ind] == '-' }
  end

  def remaining_indices_count
    remaining_indices.count
  end

  private

  def display_board
    puts "\n   -------  "
    board.each_slice(3) { |slice| p " | #{slice.join(" ")} | " }
    puts "   -------  \n"
  end

  def display_turn(turn)
    puts "\nCurrent player: #{turn}\n"
  end
end
