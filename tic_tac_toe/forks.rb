module Forks
  def fork_position(player)
    fork_sides(player) || fork_corner_side(player) || fork_corners(player)
  end

  private

  def fork_sides(player)
    sides = {
      [1, 3] => 0,
      [1, 5] => 2,
      [7, 3] => 6,
      [7, 5] => 8
    }

    sides.select { |(a, b)| board[a] == player && board[b] == player }.values.first
  end

  def fork_corners(player)
    corners = {
      [2, 6] => 3,
      [0, 8] => 3
    }

    corners.select { |(a, b)| board[a] == player && board[b] == player }.values.first
  end

  def fork_corner_side(player)
    corner_sides = {
      [0, 7] => 6,
      [2, 7] => 8,
      [6, 1] => 0,
      [8, 1] => 2,
      [2, 3] => 0,
      [8, 3] => 6,
      [0, 5] => 2,
      [6, 5] => 8
    }

    corner_sides.select { |(a, b)| board[a] == player && board[b] == player }.values.first
  end
end
