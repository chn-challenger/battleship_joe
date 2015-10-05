require_relative 'pending_coords'
include PendingNewShipCoords

class Board

  attr_reader :size, :ships

  def initialize(size=10)
    @size = size
    @ships = []
  end

  def place_ship(ship,coords,orientation)
    new_ship_coords = pending_coords(ship.size,coords,orientation)
    placement_validation(new_ship_coords)
    ship.update_ship_coords(new_ship_coords)
    ships << ship
  end

  def ship_coords
    @ship_coords = []
    @ships.each{|ship|ship.body.each{|part| @ship_coords << part[:coords]}}
    @ship_coords
  end

  def hits
    @hits = []
    @ships.each{|sp| sp.body.each{|pt| @hits << pt[:coords] if pt[:hit]}}
    @hits
  end

  def fire_missile(coords)
    missile_validation(coords)
    ships.each{|ship| return ship.hit!(coords) if ship.hit?(coords)}
    @misses << coords
  end

  def misses
    @misses ||= []
    @misses
  end

  def ocean
    @ocean =[]
    (1..size).each{|x| (1..size).each{|y| @ocean << [x,y]}}
    @ocean = @ocean - ship_coords - misses
  end

  def good_ship_parts
    @good_ship_parts = ship_coords - hits
  end

  def lose?
    ships.collect{|ship| ship.sunk?}.all?
  end

  def place_ship_at_random(ship)
    orientation = ['north', 'east', 'west', 'south'].sample
    coords = [rand(1..size), rand(1..size)]
    begin
      place_ship(ship,coords,orientation)
    rescue
      place_ship_at_random(ship)
    end
  end

  def fire_missile_at_random
    coords = [rand(1..size), rand(1..size)]
    begin
      fire_missile(coords)
    rescue
      fire_missile_at_random
    end
  end

  def show_my_board
    # ship_not_hit = ship_coords - @hits  #returns just the parts of ship not hit - ie removes the hits!
    (1..size).each do |x| #for every row
      print '[ ' # create a start of the row
      (1..size).each do |y| # for each cell on each row
        current_coord = [x, y] # set coord to current_coord
        if hits.include?(current_coord) #does the hits array contain the current_coord
          print 'Hit        ' #if it does print this
        elsif misses.include?(current_coord)
          print 'Miss       '
        elsif good_ship_parts.include?(current_coord)
          print 'Ship       '
        elsif ocean.include?(current_coord)
          print 'Ocean      '
        end
      end
      print ']'
      puts ''
    end
  end

  def print_board
    result = "<div style= 'width: 320px; float:left;'>"
    (1..size).each do |x|
      (1..size).each do |y|
        if good_ship_parts.include?([x,y])
          result += "<div style= 'display: inline-block; border: 1px solid white; background-color: green; height: 30px; width: 30px'></div>"
        elsif hits.include?([x,y])
          result += "<div style= 'display: inline-block; border: 1px solid white; background-color: red; height: 30px; width: 30px'></div>"
        elsif misses.include?([x,y])
          result += "<div style= 'display: inline-block; border: 1px solid white; background-color: yellow; height: 30px; width: 30px'></div>"
        elsif ocean.include?([x,y])
          result += "<div style= 'display: inline-block; border: 1px solid white; background-color: blue; height: 30px; width: 30px'></div>"
        end
      end
    end
    result += "</div>"
    return result
  end

private

  def new_coords(ship,coords,orientation)
    pending_coords(ship.size,coords,orientation)
  end

  def placement_validation(new_ship_coords)
    fail 'out of bounds' if outside?(new_ship_coords)
    fail 'overlapping' if overlap?(new_ship_coords)
  end

  def missile_validation(coords)
    fail 'outside range' if outside?(coords)
    fail 'already hit' if (hits + misses).include?(coords)
  end

  def outside?(new_ship_coords)
    new_ship_coords.flatten.max > size || new_ship_coords.flatten.min < 1
  end

  def overlap?(new_ship_coords)
    ship_coords & new_ship_coords != []
  end

end

#
# def scenario1
#   board = Board.new(5)
#   ship1 = Ship.new(3)
#   ship2 = Ship.new(2)
#   board.place_ship(ship1,[1,1],'south')
#   board.place_ship(ship2,[1,2],'south')
#   board.fire_missile([1,1])
#   board.fire_missile([2,1])
#   board.fire_missile([3,1])
#   board.fire_missile([3,2])
#   board.fire_missile([1,2])
#   p board.hits
#   p board.misses
#   p board.good_ship_parts
#   p board.ocean
# end
#
# scenario1








  #
  # def show_my_board
  #   ship_not_hit = ship_coords - @hits  #returns just the parts of ship not hit - ie removes the hits!
  #   (0...size).each do |x| #for every row
  #     print '[ ' # create a start of the row
  #     (0...size).each do |y| # for each cell on each row
  #       current_coord = [x, y] # set coord to current_coord
  #       if @hits.include?(current_coord) #does the hits array contain the current_coord
  #         print 'Hit        ' #if it does print this
  #       elsif @misses.include?(current_coord)
  #         print 'Miss       '
  #       elsif ship_not_hit.include?(current_coord)
  #         print 'Ship       '
  #       elsif @ocean.include?(current_coord)
  #         print 'Ocean      '
  #       end
  #     end
  #     print ']'
  #     puts ''
  #   end
  # end
  #
  # def show_opponent_board
  #   ship_not_hit = ship_coords - @hits
  #   blank = ocean + ship_not_hit
  #
  #   (0...size).each do |x|
  #     print '[ '
  #     (0...size).each do |y|
  #       current_coord = [x, y]
  #       if @hits.include?(current_coord)
  #         print 'Hit        '
  #       elsif @misses.include?(current_coord)
  #         print 'Miss       '
  #       elsif blank.include?(current_coord)
  #         print 'Ocean      '
  #       end
  #     end
  #     print ']'
  #     puts ''
  #   end
  # end
