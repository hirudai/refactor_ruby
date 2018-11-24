require './svg'
class Sparkline
  attr_reader :y_values

  def initialize(y_values)
    @y_values = y_values
  end

  def to_svg
   %Q{<svg xmlns="http://www.w3.org/2000/svg"
       xmlns:xlink="http://www.w3.org/1999/xlink" >
       #{x_axis}
       #{sparkline}
       #{spark}
   </svg>}
  end

  private

  def x_axis
    "<!-- x-axis -->
    #{SVG.line(0, 200, y_values.length, 200, '#999', 1)}"
  end

  def sparkline
    points = []
    y_values.each_index { |i| points << "#{i},#{200-y_values[i]}" }
    "<!-- sparkline -->
    #{SVG.polyline(points, 'none', '#333', 1)}"
  end
  
  SQUARE_SIDE = 4
  SPARK_COLOR = 'red'

  def spark
    final_value = y_values[-1]
    centre_x = y_values.length - 1
    centre_y = 200 - final_value
    "<!-- spark -->
    #{SVG.rect(centre_x-(SQUARE_SIDE/2), centre_y-(SQUARE_SIDE/2),
            SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0) }
    <!-- final value -->
    #{SVG.text(centre_x+6, centre_y+4, final_value, 'Verdana', 9, SPARK_COLOR)}"
  end
end

