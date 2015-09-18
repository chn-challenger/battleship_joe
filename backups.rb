require 'ship'

describe Ship do

  describe '#size' do
    it {expect(subject).to respond_to(:size).with(0).argument}
  end

  describe '#body' do
    ship = Ship.new(3)

    it {expect(subject).to respond_to(:body).with(0).argument}

    it 'should have the correct number of parts' do
      expect(ship.body.count).to eql(ship.size)
    end

    it 'should have default body part hash attributes container' do
      (0...ship.size).each do |i|
        expect(ship.body[i][:coords]).to eql([])
      end
    end

    it 'should have a starting hit status of false' do
      (0...ship.size).each do |i|
        expect(ship.body[i][:hit]).to eql(false)
      end
    end
  end

  describe "#update_ship_coords" do
    it 'updates ship coordinates with those passed to it' do
      ship = Ship.new(3)
      new_ship_coords = [[1,2],[1,3],[1,4]]
      ship.update_ship_coords(new_ship_coords)
      (0...ship.size).each do |i|
        expect(ship.body[i][:coords]).to eql(new_ship_coords[i])
      end
    end
  end

  describe "#hit?" do
    ship = Ship.new(3)
    ship_coords = [[2,3],[3,3],[4,3]]
    ship.update_ship_coords(ship_coords)

    it 'correctly return true when a ship has been hit' do
      expect(ship.hit?([3,3])).to eq(true)
    end

    it 'correctly returns false when a ship has not been hit' do
      expect(ship.hit?([5,2])).to eq(false)
    end
  end

  describe "#hit!" do
    it 'updates hit status to true when a part of the ship is hit' do
      ship = Ship.new(3)
      ship_coords = [[2,3],[3,3],[4,3]]
      ship.update_ship_coords(ship_coords)
      ship.hit!([4,3])
      expect(ship.body[2][:hit]).to eq(true)
    end
  end

  describe "#sunk?" do
    it 'returns true when all parts of a ship are hit' do
      ship = Ship.new(3)
      ship_coords = [[2,3],[3,3],[4,3]]
      ship.update_ship_coords(ship_coords)
      ship.hit!([2,3])
      ship.hit!([3,3])
      ship.hit!([4,3])
      expect(ship.sunk?).to eq(true)
    end

    it 'returns false when not all parts of a ship are hit' do
      ship = Ship.new(3)
      ship_coords = [[2,3],[3,3],[4,3]]
      ship.update_ship_coords(ship_coords)
      ship.hit!([2,3])
      ship.hit!([3,3])
      expect(ship.sunk?).to eq(false)
    end
  end

end
