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

def sparkline(points)
  "<!-- sparkline -->
  #{SVG.polyline(points, 'none', '#333', 1)}"
end

def spark(centre_x, centre_y, value)
  "<!-- spark -->
  #{SVG.rect(centre_x-(SQUARE_SIDE/2), centre_y-(SQUARE_SIDE/2),
          SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0) }
  <!-- final value -->
  #{SVG.text(centre_x+6, centre_y+4, value, 'Verdana', 9, SPARK_COLOR)}"
end

def x_axis(points)
  "<!-- x-axis -->
  #{SVG.line(0, 200, points.length, 200, '#999', 1)}"
end

tosses = values(1000)
points = []
tosses.each_index { |i| points << "#{i},#{200-tosses[i]}" }

data = %Q{<svg xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink" >
    #{x_axis(points)}
    #{spark_line(points)}
    #{spark(tosses.length-1, 200-tosses[-1], tosses[-1])}
</svg>}

#puts "Content-Type:image/svg+xml
#Content-Length:#{data.length}

puts data

