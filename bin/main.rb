#!/usr/bin/env ruby

mock_game_end = false
mock_player1_symbol = 'X'
mock_player2_symbol = 'O'
mock_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
mock_player_name = 'Active player'
mock_result = 'Draw'

def print_board(matrix)
  bu = "\n\n\n\n\e[4A\e[C" # Print new lines, move back and to the right
  ni = "\e[B" # Move down without moving horizontally
  nl = "\e[B\e[3D" # Move down and move to the left
  lu = "\e[A\e[D" # Move up and to the left
  bo = "\e[1m" # Make the terminal's font bold
  iv = "\e[7m" # Make the terminal's font invert colors
  rs = "\e[0m" # Reset the terminal's font attributes

  matrix.each do |internal|
    print bu
    max_index = internal.length - 1
    internal.each_with_index do |item, internal_index|
      printf "   #{nl} #{bo}#{item}#{rs} #{nl}#{ni}#{iv}---#{rs}"
      next unless internal_index < max_index

      print "#{iv}+#{rs}#{lu}"
      2.times { print "#{iv}|#{rs}#{lu}" }
      print "#{iv}|#{rs}"
    end
    puts
  end
  print "#{lu}\e[K\n" # Move up and errase that line, then move back down
end

# Introduction to the game
puts '~~~~~~~ Welcome to TicTacToe ~~~~~~~'
puts
print 'Enter name for player 1: '
player1_name = gets.chomp
puts "Player #{player1_name} is #{mock_player1_symbol}" # Defines Player 1
print 'Enter name for player 2: '
player2_name = gets.chomp
puts "Player #{player2_name} is #{mock_player2_symbol}" # Defines Player 2
puts
puts '~~~~~~~  Get ready to play!  ~~~~~~~'
puts
print_board(mock_board)
puts

# Mock the flow of tyhe game
# The player will come form the logic and will change to show the active player
until mock_game_end # The game_end  will come form the logic and will end the game
  print "Player #{mock_player_name} enter the coordinates for your symbol: "
  position = gets.chomp
  if (1..9).include? position.to_i
    puts
    # mock_board.method(position) this will call the object to update the current state of the board
    print_board(mock_board)
  else
    puts 'Invalid Input'
    next
  end
end

print mock_result # will print message according to the result of the game that will be provide by the game logic
