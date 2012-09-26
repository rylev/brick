module BrickGame
	require 'ray'

	class Ball
		attr_accessor :drawing
		def initialize
			@drawing = Ray::Polygon.circle([500, 780], 15, Ray::Color.blue)
		end

		def position
			@drawing.pos
		end
	end

	class Paddle
		attr_accessor :drawing
		def initialize
			@drawing = Ray::Polygon.rectangle([470, 800, 60, 10], Ray::Color.green)
		end

		def position
			@drawing.pos
		end
	end

	class Brick
		attr_accessor :drawing
		def initialize(x,y)
			@drawing = Ray::Polygon.rectangle([x, y, 40, 10], Ray::Color.red)
		end

		def position
			@drawing.pos
		end
	end

	Ray.game "My game", :size => [1000, 1000] do

		register do 
			add_hook :quit, method(:exit!)
			on :key_release, key(:q) {exit!}
		end

		scene :brick do
			@paddle = Paddle.new
			@ball = Ball.new
			@bricks = 4.times.map do |i|
	      y_cord = 300 + 15*i
	      15.times.map do |j| 
	      	x_cord = 150+45*j
	      	Brick.new(x_cord, y_cord)
	      end
	    end.flatten

			@move_right = translation(of: [2000,0], :duration => 4)
			@move_left = translation(of: [-2000,0], :duration => 4)
			@float_up = translation(of: [rand(800),-800], :duration => 4).start(@ball.drawing)
			
			@right_key_pressed = false
			@left_key_pressed = false

			on :key_press, key(:right) do
				@right_key_pressed = true
		    @move_right.start(@paddle.drawing)
		  end

		  on :key_release, key(:right) do
				@right_key_pressed = false
		  end

		  on :key_press, key(:left) do
		  	@left_key_pressed = true
		    @move_left.start(@paddle.drawing)
		  end

		  on :key_release, key(:left) do
				@left_key_pressed = false
		  end

			always do
				####!!! We can get each of the end points of the brick. This 
				#means that we can find out if the ball touchs any point between
				#those points
				@bricks.first.drawing.points.each {|p| puts p.pos}
				if @right_key_pressed 
					@move_right.update unless @paddle.position.to_a[0] >= 458
				end
				if @left_key_pressed 
					@move_left.update unless @paddle.position.to_a[0] < -470
				end
				@float_up.update
			end

			render do |win|
				win.draw @paddle.drawing
				win.draw @ball.drawing
				@bricks.each {|brick| win.draw brick.drawing}
			end

		end
		scenes << :brick
	end
end
