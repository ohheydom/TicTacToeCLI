Dir[File.join(__dir__, 'tic_tac_toe', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'tic_tac_toe', 'algorithms', '*.rb')].each { |file| require file }

TicTacToe.new(computer_algorithm: Negamax).play
