#!/usr/bin/env ruby

require_relative '../lib/game_logic'

PLAYER_NAME = 'Frank'.freeze
PLAYER_EMPTY_NAME = " \n\t \t\n ".freeze
PLAYER_SYMBOL = 'X'.freeze
PLAYER_ID = 1
MOCK_MAGIC_SQUARE = 1
MOCK_MAGIC_NUMBER = 3

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
  it '' do
    name_player.update_player_board(0, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(0, 1, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(1, 2, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 0, MOCK_MAGIC_SQUARE)
    name_player.update_player_board(2, 2, MOCK_MAGIC_SQUARE)
    expect(name_player.winner?(MOCK_MAGIC_NUMBER)).not_to eq(true)
  end
end
