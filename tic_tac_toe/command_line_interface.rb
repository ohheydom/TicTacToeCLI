class CommandLineInterface
  attr_reader :game
  X = 'x'
  O = 'o'
  YES = %w(yes y si)

  def initialize(game)
    @game = game
  end

  def play
    start_message
    grid_size_message
    loop_through_moves
    check_win_message
    play_again_message
  end

  private

  def loop_through_moves
    while game.win? == false
      if game.current_turn == X
        move_message
        player_move = gets.chomp
        valid_input?(player_move) ? game.move(player_move.to_i - 1) : invalid_input_message
      else
        game.move(game.computer_move)
      end
      display_turn_and_board
      break if game.remaining_moves_count == 0
    end
  end

  def display_turn_and_board
    display_turn(game.current_turn)
    display_board(game.board)
  end

  def display_board(board)
    dimension = Math.sqrt(board.size)
    puts "\n   #{'-' * dimension * 2}-  "
    board.each_slice(dimension) { |slice| p " | #{slice.join(' ')} | " }
    puts "   #{'-' * dimension * 2}-  "
  end

  def display_turn(turn)
    puts "\nCurrent player: #{turn}\n"
  end

  def remaining_moves_plus_one
    game.remaining_moves.map { |num| num + 1 }
  end

  def valid_input?(player_move)
    remaining_moves_plus_one.map(&:to_s).include?(player_move)
  end

  def check_win_message
    p game.win? ? "Congratulations #{game.previous_turn}!" : 'Draw!'
  end

  def invalid_input_message
    puts("\n\nPlease make a valid move.\n\n")
  end

  def move_message
    puts "\nAvailable moves: #{remaining_moves_plus_one.join ', '}"
    print 'Make your move: '
  end

  def play_again_message
    game.clear
    print 'Play Again? '
    answer = gets.chomp.downcase
    YES.include?(answer) ? play : return
  end

  def start_message
    puts "\nLet's get started!\n\n"
  end

  def grid_size_message
    print 'What size board would you like to play on? Enter only one dimension (ie 2, 3, 4): '
    answer = gets.chomp.to_i
    game.change_board_size(answer)
    display_board(game.board)
  end
end
