class Player
	attr_accessor :name, :board

	def has_board?
		!@board.nil?
	end

	def receive_shot(coordinate)
		board.fire_missile(coordinate)
	end

  def receive_shot_at_random
    board.fire_missile_at_random
  end
  
end
