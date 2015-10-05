require 'capybara/rspec'
require './app/lib/game'
require './app/lib/player'
require './app/lib/board'
require './app/lib/ship'
require './spec/spec_helper'

feature 'Game Simulation' do

  game = Game.new
  player1 = Player.new
  player2 = Player.new
  game.add_player(player1)
  game.add_player(player2)

  scenario 'Can add players' do
    expect(game.player1).to eq(player1)
    expect(game.player2).to eq(player2)
  end

  board1 = Board.new(2)
  board2 = Board.new(2)
  player1.board = board1
  player2.board = board2

  scenario 'Can assign a board to each player' do
    expect(game.player1.board).to eq(board1)
    expect(game.player2.board).to eq(board2)
  end

  scenario 'Can place ships on the board of each player' do
    fleet1 = [Ship.new(2)]
    fleet2 = [Ship.new(2)]
    board1.place_ship(fleet1[0], [1,1], 'east')
    board2.place_ship(fleet2[0], [2,1], 'east')
    expect(game.player1.board.ship_coords).to eq([[1,1],[1,2]])
    expect(game.player2.board.ship_coords).to eq([[2,1],[2,2]])
  end

  scenario 'Both player boards register a hit' do
    game.shoots([2,1])
    game.shoots([1,1])
    expect(game.player1.board.hits).to eq([[1,1]])
    expect(game.player2.board.hits).to eq([[2,1]])
  end

  scenario 'Both player boards register a miss' do
    game.shoots([1,1])
    game.shoots([2,1])
    expect(game.player1.board.misses).to eq([[2,1]])
    expect(game.player2.board.misses).to eq([[1,1]])
  end

  scenario "Player1 wins when player2's ships are sunk" do
    game.shoots([2,2])
    expect(game.winner).to eq(player1)
  end

end
