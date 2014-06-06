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
    puts "\n   -------  "
    board.each_slice(3) { |slice| p " | #{slice.join(" ")} | " }
    puts "   -------  \n"
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
    print "Make your move: "
  end

  def play_again_message
    game.clear
    print 'Play Again? '
    answer = gets.chomp.downcase
    YES.include?(answer) ? play : return
  end

  def start_message
    puts "\nLet's get started!\n\n"
    display_board(game.board)
  end
end
