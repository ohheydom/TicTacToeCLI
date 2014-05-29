module CommandLineInterface
  include Constants

  def play
    start_message
    loop_through_moves
    check_win_message
    play_again_message
  end

  private

  def loop_through_moves
    while win? == false
      if current_turn == X
        move_message
        player_move = gets.chomp
        valid_input?(player_move) ? move(player_move.to_i) : invalid_input_message
      else
        move(computer_move)
      end
      display_turn_and_board
      break if remaining_moves_count == 0
    end
  end

  def display_turn_and_board
    display_turn(current_turn)
    display_board(board)
  end

  def display_board(board)
    puts "\n   -------  "
    board.each_slice(3) { |slice| p " | #{slice.join(" ")} | " }
    puts "   -------  \n"
  end

  def display_turn(turn)
    puts "\nCurrent player: #{turn}\n"
  end

  def valid_input?(player_move)
    remaining_moves.map(&:to_s).include?(player_move)
  end

  def check_win_message
    p win? ? "Congratulations #{previous_turn}!" : 'Draw!'
  end

  def invalid_input_message
    puts("\n\nPlease make a valid move.\n\n")
  end

  def move_message
    puts "\nAvailable moves: #{remaining_moves.join ', '}"
    print "Make your move: "
  end

  def play_again_message
    clear
    print 'Play Again? '
    answer = gets.chomp.downcase
    YES.include?(answer) ? play : return
  end

  def start_message
    puts "\nLet's get started!\n\n"
    display_board(board)
  end
end
