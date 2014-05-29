module CommandLineInterface
  include Constants

  def play
    start_message
    display_board
    loop_through_moves
    check_win_message
    play_again_message
  end

  private

  def loop_through_moves
    while win? == false
      if current_turn == X
        move_message
        player_move = gets.to_i
        move(player_move)
      else
        move(computer_move)
      end
      break if remaining_moves_count == 0
    end
  end

  def move_message
    p "Available moves: #{remaining_moves.join ', '}"
    print "Make your move: "
  end

  def start_message
    puts "Let's get started!\n\n"
  end

  def check_win_message
    p win? ? "Congratulations #{previous_turn}!" : 'Draw!'
  end

  def play_again_message
    clear
    print 'Play Again? '
    answer = gets.chomp.downcase
    YES.include?(answer) ? play : return
  end
end
