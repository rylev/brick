class Brick
	attr_accessor :drawing
	def initialize(x,y)
		@drawing = Ray::Polygon.rectangle([x, y, 40, 10], Ray::Color.red)
	end

	def position
		@drawing.points.map(&:pos).map(&:to_a)
	end

	def x_cords
		self.position.map {|p| p[0]}.take(2)
	end

	def y_cords
		self.position.map {|p| p[1]}.each_slice(2).map(&:last)
	end

	def collide?(other_object)
		(self.x_cords[0]...self.x_cords[1]).include?(other_object.position.to_a[0]) &&
		(self.y_cords[0]...self.y_cords[1]).include?(-other_object.position.to_a[1])
	end
end