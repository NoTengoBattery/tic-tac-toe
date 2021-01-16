#!/usr/bin/env ruby

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol, player_id)
    @array = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
    @name = name.strip.empty? ? symbol : name
    @symbol = symbol
    @player_id = player_id
  end

  def update_player_board(index1, index2, cell_number)
    @array[index1][index2] = cell_number * @player_id
  end

  def winner?(magic_number)
    player_magic = magic_number * @player_id
    magic_sum_d1 = 0
    magic_sum_d2 = 0
    @array.length.times do |outter_index|
      magic_sum_row = 0
      magic_sum_col = 0
      @array[outter_index].length.times do |inner_index|
        magic_sum_row += @array[outter_index][inner_index]
        magic_sum_col += @array[inner_index][outter_index]
      end
      d2_index = @array.length - 1 - outter_index
      magic_sum_d1 += @array[outter_index][outter_index]
      magic_sum_d2 += @array[outter_index][d2_index]
      return true if magic_sum_row == player_magic or magic_sum_col == player_magic
    end
    return true if magic_sum_d1 == player_magic or magic_sum_d2 == player_magic

    false
  end
end

class Board
  attr_reader :magic_number

  def initialize
    @magic_number = 111
    @magic_square = [[67, 1, 43], [13, 37, 61], [31, 73, 7]]
    @interface_board = [%w[1 2 3], %w[4 5 6], %w[7 8 9]]
  end

  def cell(index1, index2)
    @magic_square[index1][index2]
  end

  def printable_board
    @interface_board.clone
  end

  def update_board(index1, index2, symbol)
    @interface_board[index1][index2] = symbol
  end

  def calculate_index(selected_index)
    outter = nil
    inner = nil
    @interface_board.each_with_index do |item, outter_index|
      inner = item.find_index(selected_index.to_s) if inner.nil?
      outter = outter_index
      break unless inner.nil?
    end
    raise 'The selected index is not available' if inner.nil?

    [outter, inner]
  end
end

class Game
  attr_reader :turn, :current_player, :valid_values, :game_draw

  def initialize
    @players_symbols = %w[X O]
    @players_ids = [101, 113]
    @players = []
    @board = Board.new
    @valid_values = (1..9)
    @turn = 1
    @_selector = 0
    @game_draw = false
  end

  def register_player(name)
    symbol = @players_symbols.shift
    id = @players_ids.shift
    player = Player.new(name, symbol, id)
    @players << player
    @current_player = player if current_player.nil?
  end

  def last_registered_player
    @players[-1]
  end

  def board
    @board.printable_board
  end

  def execute_turn(selected_index)
    outter, inner = @board.calculate_index(selected_index)
    @board.update_board(outter, inner, @current_player.symbol)
    @current_player.update_player_board(outter, inner, @board.cell(outter, inner))
    return true if current_player.winner?(@board.magic_number)

    @_selector = (@_selector + 1) % @players.length
    @current_player = @players[@_selector]
    @turn += 1
    @game_draw = true unless @valid_values.include?(@turn)
    false
  end
end
