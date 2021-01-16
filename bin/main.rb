#!/usr/bin/env ruby

require_relative '../lib/game_logic'
require_relative '../lib/blessings'

def print_board(matrix, separator)
  spacing = 1
  height = matrix.length * (2 * spacing + 2) + 1
  Blessings.insert_newline(height + 2)
  Blessings.relative_move_to(0, -height - 1)
  matrix.each_with_index do |internal, outter_index|
    offset = 0
    internal.each_with_index do |item, inner_index|
      right = inner_index != (internal.length - 1)
      bottom = outter_index != (matrix.length - 1)
      offset = Blessings.box(item, spacing, separator, bottom: bottom, right: right) - 1
      Blessings.relative_move_to(offset, 0)
    end
    Blessings.relative_move_to(-offset * internal.length, offset)
  end
  Blessings.relative_move_to(0, 2)
end

game = Game.new
puts '~~~~~~~ Welcome to TicTacToe ~~~~~~~'
puts
print 'Enter name for player 1: '
player1_name = gets.chomp
game.register_player(player1_name)
player1 = game.last_registered_player
puts "Player #{player1.name} is #{player1.symbol}"
print 'Enter name for player 2: '
player2_name = gets.chomp
game.register_player(player2_name)
player2 = game.last_registered_player
puts "Player #{player2.name} is #{player2.symbol}"
puts
puts '~~~~~~~  Get ready to play!  ~~~~~~~'
print_board(game.board, '*')

until game.game_draw
  current_player = game.current_player
  print "Turn ##{game.turn}: #{current_player.name} enter the coordinates for #{current_player.symbol}: "
  begin
    position = gets.chomp.to_i
  rescue Interrupt
    puts
    puts 'Finishing the game: execution interrupted'
    exit
  end
  if game.valid_values.include? position
    begin
      break if game.execute_turn(position)
    rescue StandardError
      Blessings.red
      puts 'The selected position is not available, please try again'
      Blessings.reset_color
    else
      print_board(game.board, '#')
    end
  else
    Blessings.red
    puts 'Your input was invalid, try a different input'
    Blessings.reset_color
    next
  end
end

print 'End of the game: '
if game.game_draw
  puts 'No winner, game ended in a draw'
else
  puts "Player #{current_player.name} (played #{current_player.symbol}) won the game in turn ##{game.turn}"
end
print_board(game.board, '+')
