size = 2
people = %w(blinry Maren LF Jakob Mullana)

people.shuffle!

groups = people.each_slice(size).to_a
p groups

if groups.last.size == 1
  groups[-2].concat groups.pop
end

groups.each_with_index do |g, i|
  puts "Room #{i + 1}: #{g.join(", ")}"
end
