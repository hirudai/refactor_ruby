require './svg'

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1])}
  a
end

SQUARE_SIDE = 4
SPARK_COLOR = 'red'

def sparkline(y_values)
  points = []
  y_values.each_index { |i| points << "#{i},#{200-y_values[i]}" }
  "<!-- sparkline -->
  #{SVG.polyline(points, 'none', '#333', 1)}"
end

def spark(y_values)
  final_value = y_values[-1]
  centre_x = y_values.length - 1
  centre_y = 200 - final_value
  "<!-- spark -->
  #{SVG.rect(centre_x-(SQUARE_SIDE/2), centre_y-(SQUARE_SIDE/2),
          SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0) }
  <!-- final value -->
  #{SVG.text(centre_x+6, centre_y+4, final_value, 'Verdana', 9, SPARK_COLOR)}"
end

def x_axis(y_values)
  "<!-- x-axis -->
  #{SVG.line(0, 200, y_values.length, 200, '#999', 1)}"
end

tosses = values(1000)

data = %Q{<svg xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink" >
    #{x_axis(tosses)}
    #{sparkline(tosses)}
    #{spark(tosses)}
</svg>}

#puts "Content-Type:image/svg+xml
#Content-Length:#{data.length}

puts data

