class Paddle
	attr_accessor :drawing
	def initialize
		@drawing = Ray::Polygon.rectangle([470, 800, 60, 10], Ray::Color.green)
	end

	def position
		@drawing.pos
	end
end