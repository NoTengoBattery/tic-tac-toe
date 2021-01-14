#!/usr/bin/env ruby
require '../lib/game_logic'

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
game = Game.new
puts '~~~~~~~ Welcome to TicTacToe ~~~~~~~'
puts
print 'Enter name for player 1: '
player1_name = gets.chomp
game.register_player(player1_name)
puts "Player #{player1_name} is X" # Defines Player 1
print 'Enter name for player 2: '
player2_name = gets.chomp
game.register_player(player2_name)
puts "Player #{player2_name} is O" # Defines Player 2
puts
puts '~~~~~~~  Get ready to play!  ~~~~~~~'
puts
print_board(game.board)
puts

until game.game_draw
  print "Turn ##{game.turn}: #{game.current_player.name} enter the coordinates for your symbol: "
  position = gets.chomp
  if (1..9).include? position.to_i
    puts
    break if game.execute_turn(position)

    print_board(game.board)
  else
    puts 'Invalid Input'
    next
  end
end

if game.game_draw
  puts 'Game ended in draw'
else
  puts "Winning move: Player #{game.current_player.name} won in turn ##{game.turn}"
end
