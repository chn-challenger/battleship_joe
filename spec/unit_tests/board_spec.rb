require './app/lib/board'

describe Board do

  before(:each) do
    @ship1 = double(:fake_ship1, size: 4, update_ship_coords: true)
    allow(@ship1).to receive(:body).and_return([{coords:[1,1],hit:false},
      {coords:[1,2],hit:false},{coords:[1,3],hit:true},{coords:[1,4],hit:true}])
    @ship2 = double(:fake_ship1, size: 3, update_ship_coords: true)
    allow(@ship2).to receive(:body).and_return([{coords:[3,3],hit:false},
      {coords:[4,3],hit:true},{coords:[5,3],hit:false}])
    @brd = Board.new
  end

  describe "#initialize/new" do
    it 'initialize with default size of 10' do
      expect(@brd.size).to eq(10)
    end

    it 'initialize with empty ships array container' do
      expect(@brd.ships).to eq([])
    end
  end

  describe "#place_ship" do
    it 'raise error when trying to place a ship out of board range' do
      expect{@brd.place_ship(@ship1,[1,0],'north')}.to raise_error "out of bounds"
    end

    it 'raises error when trying to place a ship overlapping existing ships' do
      allow(@brd).to receive(:ship_coords).and_return([[1,1],[1,2],[1,3]])
      expect{@brd.place_ship(@ship1,[1,1],'south')}. to raise_error "overlapping"
    end

    it 'on valid placement of a ship, ship is placed on the board' do
      @brd.place_ship(@ship1,[1,1],'east')
      expect(@brd.ships).to eq([@ship1])
    end

    it 'on valid placement of two ships, ships are placed on the board' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      expect(@brd.ships).to eq([@ship1,@ship2])
    end
  end

  describe "#place_ship_at_random" do
    it 'can place ship at random' do
      class FakeShip
        attr_reader :size, :body

        def initialize(size=2)
          @size = size
          @body = []
          @size.times{@body << {coords:[], hit:false}}
        end

        def update_ship_coords(new_ship_coords)
          (0...size).each{|i| body[i][:coords] = new_ship_coords[i]}
        end
      end

      ship = FakeShip.new
      srand(100)
      @brd.place_ship_at_random(ship)
      expect(@brd.ship_coords).to eq([[9, 4], [8, 4]])
    end
  end

  describe "#ship_coords" do
    it 'populates the ship_coords array with coords of one ship' do
      @brd.place_ship(@ship1,[1,1],'east')
      expect(@brd.ship_coords).to eq([[1,1],[1,2],[1,3],[1,4]])
    end

    it 'populates the ship_coords array with coords of two ships' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      expect(@brd.ship_coords).to eq([[1,1],[1,2],[1,3],[1,4],[3,3],[4,3],
        [5,3]])
    end
  end

  describe "#hits" do
    it 'populates the hits array with coords of hits on ship parts' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      expect(@brd.hits).to eq([[1, 3], [1, 4], [4, 3]])
    end
  end

  describe "#fire_missile" do
    it 'raises error when missiles are fired outside range' do
      expect{ @brd.fire_missile([0,0]) }.to raise_error "outside range"
    end

    it 'raises error when missiles ship coordinate is already hit' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      expect{ @brd.fire_missile([1,3]) }.to raise_error "already hit"
    end

    it 'registers a ship hit' do
      @brd.place_ship(@ship1,[1,1],'east')
      allow(@ship1).to receive(:hit?).and_return(true)
      allow(@ship1).to receive(:hit!).and_return(true)
      @brd.fire_missile([1,1])
      @ship1.body[0][:hit] = true
      expect(@brd.hits).to eql([[1, 1], [1, 3], [1, 4]])
    end

    it 'registers a missed hit' do
      @brd.place_ship(@ship1,[1,1],'east')
      allow(@ship1).to receive(:hit?).and_return(false)
      @brd.fire_missile([1,6])
      @brd.fire_missile([2,9])
      expect(@brd.misses).to eql([[1,6], [2,9]])
    end
  end

  describe "#misses" do
    it 'populates the misses array with coords of misses' do
      @brd.fire_missile([1,6])
      @brd.fire_missile([2,8])
      expect(@brd.misses).to eq([[1, 6], [2, 8]])
    end
  end

  describe "#ocean" do
    it 'populates an ocean board at initialization' do
      board = Board.new(2)
      expect(board.ocean).to eq([[1, 1], [1, 2], [2, 1], [2, 2]])
    end

    it 'populates with ocean coords after ship placement' do
      board = Board.new(4)
      board.place_ship(@ship1,[1,1],'east')
      expect(board.ocean).to eq([[2, 1], [2, 2], [2, 3], [2, 4], [3, 1], [3, 2],
       [3, 3], [3, 4], [4, 1], [4, 2], [4, 3], [4, 4]])
    end

    it 'populates with ocean coords after ship placement and firing missiles' do
      board = Board.new(4)
      board.place_ship(@ship1,[1,1],'east')
      allow(@ship1).to receive(:hit?).and_return(false)
      board.fire_missile([2,1])
      board.fire_missile([3,1])
      expect(board.ocean).to eq([[2, 2], [2, 3], [2, 4], [3, 2], [3, 3], [3, 4],
       [4, 1], [4, 2], [4, 3], [4, 4]])
    end
  end

  describe "#good_ship_parts" do
    it 'populates ship parts which has not been hit' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      expect(@brd.good_ship_parts).to eq([[1, 1], [1, 2], [3, 3], [5, 3]])
    end
  end

  describe "#lose?" do
    it 'returns true if all the ships are sunk' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      allow(@ship1).to receive(:sunk?).and_return(true)
      allow(@ship2).to receive(:sunk?).and_return(true)
      expect(@brd.lose?).to eq(true)
    end

    it 'returns false if at least one ship not sunk' do
      @brd.place_ship(@ship1,[1,1],'east')
      @brd.place_ship(@ship2,[3,3],'south')
      allow(@ship1).to receive(:sunk?).and_return(true)
      allow(@ship2).to receive(:sunk?).and_return(false)
      expect(@brd.lose?).to eq(false)
    end
  end

end
