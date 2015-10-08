require './app/lib/game'
require './app/lib/player'
require './app/lib/board'
require './app/lib/ship'


game = Game.new

player1 = Player.new
player2 = Player.new

fleet1 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]
fleet2 = [Ship.new(2), Ship.new(3), Ship.new(4), Ship.new(4), Ship.new(5)]

board1 = Board.new
board2 = Board.new

game.add_player(player1)
game.add_player(player2)

p game.player1.name

# player1.board = board1
# player2.board = board2
#
# fleet1.each do |ship|
#   board1.place_ship_at_random(ship)
# end
#
# fleet2.each do |ship|
#   board2.place_ship_at_random(ship)
# end
#
# counter = 0
# shot = ""
# while shot != "winner"
#   shot = game.shoots_at_random
#   counter += 1
# end
#
# puts player1.board.print_board


# checking winner not using random shooting methods

# game = Game.new
#
# player1 = Player.new
# player2 = Player.new
#
# fleet1 = [Ship.new(2)]
# fleet2 = [Ship.new(2)]
#
# board1 = Board.new(2)
# board2 = Board.new(2)
#
# game.add_player(player1)
# game.add_player(player2)
#
# player1.board = board1
# player2.board = board2
#
# fleet1.each do |ship|
#   board1.place_ship(ship, [1,1], 'east')
# end
#
# fleet2.each do |ship|
#   board2.place_ship(ship, [2,1], 'east')
# end
#
# game.shoots([2,1])
# game.shoots([1,1])
# winner = game.shoots([2,2])
# p winner


# p board1.show_my_board
# puts ""
# puts ""
# p board2.show_my_board
