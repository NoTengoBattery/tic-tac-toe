#!/usr/bin/env ruby

require_relative '../lib/game_logic'
require_relative '../lib/blessings'

def print_board(matrix)
  spacing = 1
  height = matrix.length * (2 * spacing + 2) + 1
  Blessings.insert_newline(height)
  Blessings.relative_move_to(0, -height)
  matrix.each do |internal|
    offset = 0
    internal.each do |item|
      offset = Blessings.box(item, spacing, '#', top: true, left: true, bottom: true, right: true) - 1
      Blessings.relative_move_to(offset, 0)
    end
    Blessings.relative_move_to(-offset * internal.length, offset)
  end
  Blessings.relative_move_to(0, 1)
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
puts
print_board(game.board)
puts

until game.game_draw
  print "Turn ##{game.turn}: #{game.current_player.name} enter the coordinates for your symbol: "
  position = gets.chomp.to_i
  if game.valid_values.include? position
    puts
    begin
      break if game.execute_turn(position)
    rescue StandardError
      puts 'Position Already Chosen'
    else
      print_board(game.board)
    end
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
