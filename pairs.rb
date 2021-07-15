# frozen_string_literal: true

def repetitions?(groups, previous_groups)
  groups.any? do |g|
    previous_groups.any? do |pg|
      # It's bad if g is a subset of pg:
      g.difference(pg).empty?
    end
  end
end

size = 3
people = %w[Edgar Jakob Paolo skalabyrinth hanno Piko Winnie Lena Leah mad Daniel_Bohrer mo blinry Lena_aus_Leipzig]

previous_groups = IO.readlines('previous_groups').filter { |l| !l.empty? }.map do |line|
  line.chomp.split(',').map(&:strip).sort
end

100_000.times do |i|
  people.shuffle!
  groups = people.each_slice(size).to_a

  groups[-2].concat groups.pop if groups.last.size == 1
  groups.map!(&:sort)

  # Try again if there's a duplicate.
  next if repetitions?(groups, previous_groups)

  open('previous_groups', 'a') do |f|
    f.puts
    puts "Found a grouping after #{i + 1} attempts:"
    groups.each_with_index do |g, room_number|
      puts "Room #{room_number + 1}: #{g.join(', ')}"
      f.puts g.join(', ')
    end
  end

  exit # we are very happy here
end

puts 'Didn\'t find new pairings for everyone'
