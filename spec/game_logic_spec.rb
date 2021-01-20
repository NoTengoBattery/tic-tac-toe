#!/usr/bin/env ruby

require_relative '../lib/game_logic'

PLAYER_NAME = 'Frank'.freeze
PLAYER2_NAME = 'Chris'.freeze
PLAYER_EMPTY_NAME = " \n\t \t\n ".freeze
PLAYER_SYMBOL = 'X'.freeze
PLAYER_ID = 1
MOCK_MAGIC_SQUARE = 1
MOCK_MAGIC_NUMBER = 3
REAL_MAGIC_NUMBER = 111

RSpec.describe 'Player' do
  let(:noname_player) { Player.new(PLAYER_EMPTY_NAME, PLAYER_SYMBOL, PLAYER_ID) }
  let(:name_player) { Player.new(PLAYER_NAME, PLAYER_SYMBOL, PLAYER_ID) }
  it 'creates a player with a name' do
    expect(name_player.name).to eq(PLAYER_NAME)
  end
  it 'creates a player with symbol as name when given an empty string' do
    expect(noname_player.name).to eq(PLAYER_SYMBOL)
  end
  it 'creates a player without an empty name when given an empty string' do
    expect(noname_player.name).not_to eq(PLAYER_EMPTY_NAME)
  end
  it 'creates a player with a symbol' do
    expect(name_player.symbol).to eq(PLAYER_SYMBOL)
  end
  it 'detects a winner when winning condition in a column is made' do
    name_player.update_player_board(0, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(0, 1, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(0, 2, MOCK_MAGIC_SQUARE)
    expect(name_player.winner?(MOCK_MAGIC_NUMBER)).to eq(true)
  end
  it 'detects a winner when winning condition in a row is made' do
    name_player.update_player_board(0, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(1, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 0, MOCK_MAGIC_SQUARE)
    expect(name_player.winner?(MOCK_MAGIC_NUMBER)).to eq(true)
  end
  it 'detects a winner when winning condition in a diagonal is made' do
    name_player.update_player_board(0, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(1, 1, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 2, MOCK_MAGIC_SQUARE)
    expect(name_player.winner?(MOCK_MAGIC_NUMBER)).to eq(true)
  end
  it 'detects when there is no winning condition on the board' do
    name_player.update_player_board(0, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(0, 1, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(1, 2, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 2, MOCK_MAGIC_SQUARE)
    expect(name_player.winner?(MOCK_MAGIC_NUMBER)).not_to eq(true)
  end
end

RSpec.describe 'Board' do
  let(:board) { Board.new }
  let(:outer) { rand(0..2) }
  let(:inner) { rand(0..2) }
  let(:input) { outer * 3 + inner + 1 }
  it 'calculates outer index' do
    outer_index, _inner_index = board.calculate_index(input)
    expect(outer_index).to eq(outer)
  end
  it 'calculates inner index' do
    _outer_index, inner_index = board.calculate_index(input)
    expect(inner_index).to eq(inner)
  end
  it 'updates the cell inside the board' do
    outer, inner = board.calculate_index(input)
    board.update_board(outer, inner, PLAYER_SYMBOL)
    expect(board.printable_board[outer][inner]).to eq(PLAYER_SYMBOL)
  end
  it 'raises an exception if the cell is already taken' do
    outer, inner = board.calculate_index(input)
    board.update_board(outer, inner, PLAYER_SYMBOL)
    expect { board.calculate_index(input) }.to raise_error(StandardError)
  end
end

RSpec.describe 'Game' do
  let(:game) { Game.new }
  let(:input) { rand(1..9) }
  it 'register a player and it is not nil' do
    game.register_player(PLAYER_NAME)
    expect(game.last_registered_player).not_to be(nil)
  end
  it 'register a player and it have the correct name' do
    game.register_player(PLAYER_NAME)
    expect(game.last_registered_player.name).to eq(PLAYER_NAME)
  end
  it 'register two players' do
    game.register_player(PLAYER_NAME)
    player1 = game.last_registered_player
    game.register_player(PLAYER2_NAME)
    player2 = game.last_registered_player
    expect(player1.name).not_to eq(player2.name)
  end
  it 'returns a representation of the board' do
    expect(game.board).is_a?(Array)
  end
  it 'increments the turn when the turn is valid' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    current_turn = game.turn
    game.execute_turn(input)
    next_turn = game.turn
    expect(next_turn).to eq(current_turn + 1)
  end
  it 'repeats the same turn when the turn is invalid' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    game.execute_turn(input)
    current_turn = game.turn
    begin
      game.execute_turn(input)
    rescue StandardError
      next_turn = game.turn
    end
    expect(next_turn).to eq(current_turn)
  end
  it 'changes the current player when the turn is valid' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    current_player = game.current_player
    game.execute_turn(input)
    next_player = game.current_player
    expect(next_player).not_to eq(current_player)
  end
  it 'keeps the same player when the turn is invalid' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    game.execute_turn(input)
    current_player = game.current_player
    begin
      game.execute_turn(input)
    rescue StandardError
      next_player = game.current_player
    end
    expect(next_player).to eq(current_player)
  end
  it 'See if player 1 wins' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    game.execute_turn(1)
    game.execute_turn(8)
    game.execute_turn(2)
    game.execute_turn(7)
    game.execute_turn(3)
    expect(game.current_player.name).to eq(PLAYER_NAME)
    expect(game.current_player.winner?(REAL_MAGIC_NUMBER)).to eq(true)
  end
  it 'See if player 2 wins' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    game.execute_turn(5)
    game.execute_turn(1)
    game.execute_turn(9)
    game.execute_turn(2)
    game.execute_turn(7)
    game.execute_turn(3)
    expect(game.current_player.name).to eq(PLAYER2_NAME)
    expect(game.current_player.winner?(REAL_MAGIC_NUMBER)).to eq(true)
  end
  it 'see if the game is a draw' do
    game.register_player(PLAYER_NAME)
    game.register_player(PLAYER2_NAME)
    game.execute_turn(1)
    game.execute_turn(3)
    game.execute_turn(2)
    game.execute_turn(4)
    game.execute_turn(6)
    game.execute_turn(5)
    game.execute_turn(7)
    game.execute_turn(8)
    game.execute_turn(9)
    expect(game.game_draw).to eq(true)
  end
end
