require './svg'
require './sparkline'

def toss
  2 * (rand(2)*2 - 1)
end

def values(n)
  a = [0]
  n.times { a << (toss + a[-1])}
  a
end

#puts "Content-Type:image/svg+xml
#Content-Length:#{data.length}

puts Sparkline.new(values(1000)).to_svg
