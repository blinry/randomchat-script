def has_no_repetitions groups, previous_groups
    groups.each do |g|
        previous_groups.each do |pg|
            # It's bad if g is a subset of pg:
            if g.difference(pg).empty?
                return false
            end
        end
    end
    return true
end

size = 2
people = %w(Edgar Jakob Paolo skalabyrinth hanno Piko Winnie Lena Leah mad Daniel_Bohrer mo blinry Lena_aus_Leipzig)

previous_groups =  IO.readlines("previous_groups").filter{|l| not l.empty?}.map { |line|
    line.chomp.split(",").map(&:strip).sort
}

100000.times do |i|
    people.shuffle!
    groups = people.each_slice(size).to_a

    if groups.last.size == 1
      groups[-2].concat groups.pop
    end
    groups.map!(&:sort)

    # Try again if there's a duplicate.
    next unless has_no_repetitions(groups, previous_groups)

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
