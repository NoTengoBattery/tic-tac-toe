#!/usr/bin/env ruby

mock_game_end = false
mock_player1_symbol = 'X'
mock_player2_symbol = 'O'
mock_board = [['O', ' ', 'X'], [' ', 'X', ' '], ['O', ' ', 'X']]

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

puts '~~~~~~~ Welcome to TicTacToe ~~~~~~~'
puts
print 'Enter name for player 1: '
player1_name = gets.chomp
puts "Player #{player1_name} is #{mock_player1_symbol}"
print 'Enter name for player 2: '
player2_name = gets.chomp
puts "Player #{player2_name} is #{mock_player2_symbol}"
puts

puts '~~~~~~~  Get ready to play!  ~~~~~~~'
puts

print_board(mock_board)
