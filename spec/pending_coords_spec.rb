require 'pending_coords'
include PendingNewShipCoords

class TestPendingCoordModuleDummyClass
end

describe TestPendingCoordModuleDummyClass do

  before(:each) do
    @dummy_class = TestPendingCoordModuleDummyClass.new
    @dummy_class.extend(PendingNewShipCoords)
  end

  it{expect(@dummy_class).to respond_to(:pending_coords).with(3).argument}

  it 'output correct pending coords when given orientation of north' do
    pending_coords = @dummy_class.pending_coords(3,[4,2],'north')
    expect(pending_coords).to eq([[4,2],[3,2],[2,2]])
  end

  it 'output correct pending coords when given orientation of west' do
    pending_coords = @dummy_class.pending_coords(2,[4,2],'east')
    expect(pending_coords).to eq([[4,2],[4,3]])
  end

  it 'output correct pending coords when given orientation of south' do
    pending_coords = @dummy_class.pending_coords(3,[4,2],'south')
    expect(pending_coords).to eq([[4,2],[5,2],[6,2]])
  end

  it 'output correct pending coords when given orientation of east' do
    pending_coords = @dummy_class.pending_coords(2,[4,5],'east')
    expect(pending_coords).to eq([[4,5],[4,6]])
  end

end
