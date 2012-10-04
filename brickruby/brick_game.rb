module BrickGame
  require 'ray'
  require './brick'
  require './paddle'
  require './ball'

  Ray.game "My game", :size => [1000, 1000] do

    register do
      add_hook :quit, method(:exit!)
      on :key_release, key(:q) {exit!}
    end

    scene :brick do
      @paddle = Paddle.new
      @ball = Ball.new(500, 780)
      @bricks = 4.times.map do |i|
        y_cord = 300 + 15*i
        15.times.map do |j|
          x_cord = 150+45*j
          Brick.new(x_cord, y_cord)
        end
      end.flatten

      @move_right = translation(of: [2000,0], :duration => 4)
      @move_left = translation(of: [-2000,0], :duration => 4)
      @float_up = translation(of: [rand(800),-800], :duration => 4)

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
        if @right_key_pressed
          @move_right.update unless @paddle.position.to_a[0] >= 458
        end
        if @left_key_pressed
          @move_left.update unless @paddle.position.to_a[0] < -470
        end
        @float_up.start(@ball.drawing)
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
