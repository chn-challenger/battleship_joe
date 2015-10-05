require './lib/game'
require './lib/player'
require './lib/board'
require './lib/ship'


game = Game.new

player1 = Player.new
player2 = Player.new

fleet1 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]
fleet2 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]

board1 = Board.new
board2 = Board.new

game.add_player(player1)
game.add_player(player2)

player1.board = board1
player2.board = board2

fleet1.each do |ship|
  board1.place_ship_at_random(ship)
end

fleet2.each do |ship|
  board2.place_ship_at_random(ship)
end

while game.winner == false
  game.shoots_at_random
end


# game.shoots([1,1])
# game.shoots([1,1])
# game.shoots([10,10])
# game.shoots([10,10])
# 10.times{game.shoots_at_random}


p board1.show_my_board
puts ""
puts ""
p board2.show_my_board
