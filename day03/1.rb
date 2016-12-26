#!/usr/bin/env ruby

triangles = File.readlines("input.txt").map{|triangle| triangle.split(' ').map(&:to_i)}
possible = 0
triangles.each do |sides|
    sides = sides.sort
    if sides[0] + sides[1] > sides[2]
        possible += 1
    end
end
puts "#{possible} are possible rowwise"

columnwise_triangles = triangles.transpose

possible = 0
columnwise_triangles.each do |row|
    row.each_slice(3) do |sides|
        sides = sides.sort
        if sides[0] + sides[1] > sides[2]
            possible += 1
        end
    end
end
puts "#{possible} are possible columnwise"




