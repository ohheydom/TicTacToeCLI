#Tic Tac Toe

I built this as a test project for an apprenticeship.

This was built in Ruby and utilizes a command line interface.

##Instructions

To start, type the following into the command prompt.

```
ruby play.rb
```

The numbers 1 through 9 correspond to each individual square. Like so:

```
1 2 3
4 5 6
7 8 9
```

The game will ask for your move. Simply enter the number that corresponds to the square you wish to mark. The available moves are listed at the bottom.

## Algorithms

The computer can utilize a few algorithms to select a move. The default is AlphaBetaMinimax, the others are called Minimax, Negamax, and ElseMethod. In order to pass in a different algorithm, edit the play.rb file like so:

```
TicTacToe.new(computer_algorithm: ElseMethod).play
```
