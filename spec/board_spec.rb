require 'board'

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
    it 'raises error when missles are fired outside range' do
      expect{ @brd.fire_missile([0,0]) }.to raise_error "outside range"
    end

    it 'raises error when missles ship coordinate is already hit' do
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






  # before(:each) do
  #   @ship1 = double(:fake_ship1, size: 4, update_ship_coords: true)
  #   allow(@ship1).to receive(:body).and_return([{coords:[1,1],hit:false},
  #     {coords:[1,2],hit:false},{coords:[1,3],hit:true},{coords:[1,4],hit:true}])

  #   @ship2 = double(:fake_ship1, size: 3, update_ship_coords: true)
  #   allow(@ship2).to receive(:body).and_return([{coords:[3,3],hit:false},
  #     {coords:[4,3],hit:true},{coords:[5,3],hit:false}])

  #   @brd = Board.new
  # end




end
#
#   ship1 = double(:ship)
#   board1 = Board.new
#   allow(ship1).to receive(:size).and_return(2)
#   allow(ship1).to receive(:body).and_return([{:grid_coords => []},{:grid_coords => []}])
#
#
#   describe '#initialize/new' do
#     it 'when created has a default size of 10' do
#       expect(subject.size).to eql(10)
#     end
#     it 'when created has a default empty ships array' do
#       expect(subject.ships).to eql([])
#     end
#   end
#
#   describe '#new_coords'
#
#   end
  #
  # describe '#new_ship_coords' do
  #   it 'returns the correct coords when orientation is south' do
  #     board = Board.new
  #     expect(board.new_ship_coords(2,4,5,'south')).to eql([[4, 5], [5, 5]])
  #   end
  #
  #   it 'returns the correct coords when orientation is north' do
  #     board = Board.new
  #     expect(board.new_ship_coords(2,3,6,'north')).to eql([[3, 6], [2, 6]])
  #   end
  #
  #   it 'returns the correct coords when orientation is east' do
  #     board = Board.new
  #     expect(board.new_ship_coords(2,4,5,'east')).to eql([[4, 5], [4, 6]])
  #   end
  #
  #   it 'returns the correct coords when orientation is west' do
  #     board = Board.new
  #     expect(board.new_ship_coords(2,2,3,'west')).to eql([[2, 3], [2, 2]])
  #   end
  # end
  #
  # # describe '#outside?' do
  # #   it 'raise error when asked to place a ship outside of grid range' do
  # #     board = Board.new(6)
  # #     ship1 = double(:ship_object)
  # #     allow(ship1).to receive(:size).and_return(3)
  # #     expect(board.outside?(ship1,4,2,'south')).to eql(true)
  # #     expect(board.outside?(ship1,1,2,'north')).to eql(true)
  # #     expect(board.outside?(ship1,4,1,'west')).to eql(true)
  # #     expect(board.outside?(ship1,4,4,'east')).to eql(true)
  # #   end
  # # end
  #
  # describe '#place_ship' do
  #   it 'appends a ship to the ships array on the board' do

  #     board1.place_ship(ship1,2,3,'south')
  #     expect(board1.ships.first).to eql(ship1)
  #   end
  # end
  #
  # describe '#current_ship_coords' do
  #   it "current_ship_coords" do
  #     ship1 = double(:ship1)
  #     ship2 = double(:ship2)
  #     allow(ship1).to receive(:body).and_return([{:grid_coords => [1,1]},{:grid_coords => [1,2]}])
  #     allow(ship2).to receive(:body).and_return([{:grid_coords => [2,3]},{:grid_coords => [2,4]}])
  #     class Board
  #       attr_accessor :ships
  #     end
  #     board1 = Board.new
  #     board1.ships << ship1
  #     board1.ships << ship2
  #     expect(board1.ship_coords).to eql([[1,1], [1,2], [2,3], [2,4]])
  #   end
  #
  #   # it "should know when ships overlap" do
  #   #   ship1 = double(:ship1)
  #   #   ship2 = double(:ship2)
  #   #   ship3 = double(:ship3)
  #   #   allow(ship3).to receive(:size).and_return(3)
  #   #   allow(ship1).to receive(:body).and_return([{:grid_coords => [1,1]},{:grid_coords => [1,2]}])
  #   #   allow(ship2).to receive(:body).and_return([{:grid_coords => [2,3]},{:grid_coords => [2,4]}])
  #   #   class Board
  #   #     attr_accessor :ships
  #   #   end
  #   #   board1 = Board.new
  #   #   board1.ships << ship1
  #   #   board1.ships << ship2
  #   #   expect(board1.overlap?(ship3,0,1,'south')).to eql(true)
  #   # end
  # end
  #
  # describe '#fire_missle' do
  #   it { expect(subject).to respond_to(:fire_missle).with(2).argument }
  #   it "can't fire missle outside range" do
  #     expect{subject.fire_missle(20,20)}.to raise_error "outside range"
  #   end
  #   it "can't fire if already fired at location" do
  #     subject.fire_missle(2,2)
  #     expect{subject.fire_missle(2,2)}.to raise_error "already fired at this location"
  #   end
  #
  #   it "should register a miss" do
  #     subject.fire_missle(3,3)
  #     subject.fire_missle(2,2)
  #     expect(subject.misses).to eql([[3,3],[2,2]])
  #   end
  #
  #   it 'should register a hit' do
  #       ship1 = double(:ship1)
  #       allow(ship1).to receive(:size).and_return(2)
  #       allow(ship1).to receive(:body).and_return([{:grid_coords => [1,1]},{:grid_coords => [1,2]}])
  #       subject.place_ship(ship1, 1, 1, 'south')
  #       subject.fire_missle(1,1)
  #       expect(subject.hits).to eql([[1,1]])
  #   end
  # end

# end
