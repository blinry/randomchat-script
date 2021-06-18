size = 3
people = %w(blinry Winston LF Pecca Hanno Winnie Lena karlabyrinth)

previous_groups =  IO.readlines("previous_groups").filter{|l| not l.empty?}.map { |line|
    line.chomp.split(",").map(&:strip).sort
}

10000.times do |i|
    people.shuffle!
    groups = people.each_slice(size).to_a

    if groups.last.size == 1
      groups[-2].concat groups.pop
    end
    groups.map!(&:sort)

    next unless previous_groups.intersection(groups).empty?

    open("previous_groups", "a") do |f|
        f.puts
        puts "Found a grouping after #{i+1} attempts:"
        groups.each_with_index do |g, i|
          puts "Room #{i + 1}: #{g.join(", ")}"
          f.puts g.join(", ")
        end
    end

    exit # we are very happy here
end

puts "Didn't find new pairings for everyone"
