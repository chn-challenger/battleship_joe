module PendingNewShipCoords

  def pending_coords(size,coords,orientation)
    pending_ship_coords = [coords]
    (size - 1).times do
      pending_ship_coords << next_coords(pending_ship_coords.last,orientation)
    end
    pending_ship_coords
  end

  private

  def next_coords(prev_coords,orientation)
    case orientation
      when 'north' then [prev_coords[0]-1,prev_coords[1]]
      when 'east' then [prev_coords[0],prev_coords[1]+1]
      when 'south' then [prev_coords[0]+1,prev_coords[1]]
      when 'west' then [prev_coords[0],prev_coords[1]-1]
    end
  end

end
