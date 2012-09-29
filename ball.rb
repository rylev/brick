class Ball
	attr_accessor :drawing
	def initialize
		@drawing = Ray::Polygon.circle([500, 780], 15, Ray::Color.blue)
	end

	def position
		@drawing.pos
	end
end