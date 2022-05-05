# frozen_string_literal: true

def repetitions?(groups, previous_groups)
  groups.any? do |g|
    previous_groups.any? do |pg|
      # It's bad if g and pg have more than 1 member in common
      g.intersection(pg).size > 1
    end
  end
end

size = 2
people = %w[A B C D E F]

previous_groups = IO.readlines('previous_groups').filter { |l| !l.empty? }.map do |line|
  line.chomp.split(',').map(&:strip).sort
end

100_000.times do |i|
  people.shuffle!
  groups = people.each_slice(size).to_a

  groups[-2].concat groups.pop if groups.last.size == 1
  groups.map!(&:sort)

  groups.each_with_index{|g,i| g.unshift((i+1).to_s)}

  # Try again if there's a duplicate.
  next if repetitions?(groups, previous_groups)

  open('previous_groups', 'a') do |f|
    f.puts
    puts "Found a grouping after #{i + 1} attempts:"
    groups.each_with_index do |g, room_number|
      puts "#{g.join(', ')}"
      f.puts g.join(', ')
    end
  end

  exit # we are very happy here
end

puts 'Didn\'t find new pairings for everyone'
