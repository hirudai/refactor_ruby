require './svg'

NUMBER_OF_TOSSES = 1000

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

def spark(centre_x, centre_y, value)
  "#{SVG.rect(centre_x-(SQUARE_SIDE/2), centre_y-(SQUARE_SIDE/2),
          SQUARE_SIDE, SQUARE_SIDE, SPARK_COLOR, 'none', 0) }
  #{SVG.text(centre_x+6, centre_y+4, value, 'Verdana', 9, SPARK_COLOR)}"
end

tosses = values(NUMBER_OF_TOSSES)
points = []
tosses.each_index { |i| points << "#{i},#{200-tosses[i]}" }

data = %Q{<svg xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink" >
    <!-- x-axis -->
    #{SVG.line(0, 200, NUMBER_OF_TOSSES, 200, '#999', 1)}
    #{SVG.polyline(points, 'none', '#333', 1)}
    #{spark(NUMBER_OF_TOSSES-1, 200-tosses[-1], tosses[-1])}
</svg>}

#puts "Content-Type:image/svg+xml
#Content-Length:#{data.length}

puts data

