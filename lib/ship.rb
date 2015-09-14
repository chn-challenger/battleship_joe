class Ship

  attr_reader :size, :body

  def initialize(size=2)
    @size = size
    @body = []
    @size.times{@body << {coords:[], hit:false}}
  end

  def update_ship_coords(new_ship_coords)
    (0...size).each{|i| body[i][:coords] = new_ship_coords[i]}
  end

  def hit?(coords)
    body.collect{|hash| hash[:coords]}.include?(coords)
  end

  def hit!(coords)
    body.each{|hash| hash[:hit] = true if hash[:coords] == coords}
  end

  def sunk?
    body.collect{|part| part[:hit]}.all?
  end
end

# ship1 = Ship.new(4)
# p ship1.pending_ship_coords([2,3],'south')
# ship1.body[0][:hit] = true
# ship1.body[1][:hit] = true
# ship1.body[2][:hit] = true
# ship1.body[3][:hit] = true
# p ship1.body.collect{|hash| hash[:hit]}.all?
# array = [[2, 3], [3, 3], [4, 3], [5, 3]]
# p array.flatten
