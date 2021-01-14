#!/usr/bin/env ruby

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol, player_id)
    @array = Array.new(3, [0,0,0])
    @name = name
    @symbol = symbol
    @player_id = player_id
  end

  public

  def update_player_board(index1, index2, cell_number)
    @array[index1][index2] = cell_number * @player_id
  end

  def winner?(magic_number)
    @player_magic = magic_number * player_id
    result = false
    result |= @array[0][0] + @array[0][1] + @array[0][2] == @player_magic
    result |= @array[1][0] + @array[1][1] + @array[1][2] == @player_magic
    result |= @array[2][0] + @array[2][1] + @array[2][2] == @player_magic
    result |= @array[0][0] + @array[1][0] + @array[2][0] == @player_magic
    result |= @array[0][1] + @array[1][1] + @array[2][1] == @player_magic
    result |= @array[0][2] + @array[1][2] + @array[2][2] == @player_magic
    result |= @array[0][0] + @array[1][1] + @array[2][2] == @player_magic
    result |= @array[0][2] + @array[1][1] + @array[2][0] == @player_magic
    result
  end
end

class Board

  @magic_square = [[67, 1, 43].freeze, [13, 37, 61].freeze, [31, 73, 7].freeze].freeze
  @interface_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]].freeze

  def cell(index1, index2)
    @magic_square[index1][index2]
  end

  def get_printable_board
    printable_board = @interface_board.clone
  end

  def update_board(index1, index2, symbol)
    @interface_board[index1][index2] = symbol
  end
end

class Game

end
