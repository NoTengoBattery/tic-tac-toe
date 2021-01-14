#!/usr/bin/env ruby

mock_game_end = false
mock_player1_symbol = 'X'
mock_player2_symbol = 'O'
mock_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]

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
# This is mock logic
mock_player_name = player1_name
# Here ends mock logic
puts "Player #{player1_name} is #{mock_player1_symbol}" # Defines Player 1
print 'Enter name for player 2: '
player2_name = gets.chomp
puts "Player #{player2_name} is #{mock_player2_symbol}" # Defines Player 2
puts
puts '~~~~~~~  Get ready to play!  ~~~~~~~'
puts
print_board(mock_board)
puts

mock_player_selector = false
mock_turn_counter = 1
mock_is_winning = false

until mock_game_end
  print "Turn ##{mock_turn_counter}: player #{mock_player_name} enter the coordinates for your symbol: "
  position = gets.chomp
  if (1..9).include? position.to_i
    puts
    # This is mock logic, the real logic is inside the Game class
    mock_is_winning = rand(100) <= 25 # This will mock the signal from the game logic (without computing it)
    mock_game_end = (mock_turn_counter == 9 || mock_is_winning)
    break if mock_game_end

    mock_player_selector = !mock_player_selector
    mock_player_name = mock_player_selector ? player2_name : player1_name
    mock_turn_counter += 1
    # Here the mock logic ends
    print_board(mock_board)
  else
    puts 'Invalid Input'
    next
  end
end

if mock_is_winning
  puts "Winning move: Player #{mock_player_name} won in turn ##{mock_turn_counter}"
else
  puts 'Game ended in draw'
end
