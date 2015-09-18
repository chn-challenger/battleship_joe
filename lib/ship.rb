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
