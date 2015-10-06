module HTMLprinter

  def print_board
    result = "<section class='board'>"
    (1..size).to_a.reverse.each do |x| column = "#{x}"
      (1..size).each do |y| row = "#{y}"
        if good_ship_parts.include?([x,y])
          result += "<div class='grid ship' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        elsif hits.include?([x,y])
          result += "<div class='grid hits' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        elsif misses.include?([x,y])
          result += "<div class='grid misses' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        else
          result += "<div class='grid ocean' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        end
      end
    end
    result += "</section>"
    return result
  end


  def print_opponent_board
    opponent_result = "<section class='board'>"
    (1..size).to_a.reverse.each do |x| column = "#{x}"
      (1..size).each do |y| row = "#{y}"
        if hits.include?([x,y])
          opponent_result += "<div class='grid hits' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        elsif misses.include?([x,y])
          opponent_result += "<div class='grid misses' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        else
          opponent_result += "<div class='grid ocean' id='grid-#{column}-#{row}'>#{column}-#{row}</div>"
        end
      end
    end
    opponent_result += "</section>"
    return opponent_result
  end

end
