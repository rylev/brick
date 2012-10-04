class Ball
  attr_accessor :x, :y, :drawing
  def initialize(x, y)
    @x, @y = x, y
    @drawing = Ray::Polygon.circle([@x, @y], 15, Ray::Color.blue)
  end

  def position
    drawing.pos
  end

  def translate(x_offset, y_offset)
    @x += x_offset
    @y += y_offset
  end
end