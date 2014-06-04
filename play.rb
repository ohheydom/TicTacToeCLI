Dir[File.join(__dir__, 'tic_tac_toe', '*.rb')].each { |file| require_relative file }
Dir[File.join(__dir__, 'tic_tac_toe', 'algorithms', '*.rb')].each { |file| require_relative file }

TicTacToe.new.play
