#!/usr/bin/env ruby

NORTH = [0, 1]
EAST = [1, 0]
SOUTH = [0, -1]
WEST = [-1, 0]
RIGHT = 'R'
LEFT = 'L'
DIRS = [NORTH, EAST, SOUTH, WEST]

# turn accepts the direction the user is currently facing and the turn (LEFT or RIGHT) that they want to make,
# and returns the new direction they are facing
def turn(facing, turn)
    current_index = DIRS.index(facing)
    if current_index < 0
        raise "Unknown facing direction ${facing}"
    end
    if turn == RIGHT
        current_index += 1
    elsif turn == LEFT
        current_index -= 1
    else
        raise "Unknown turn #{turn}"
    end
    if current_index < 0
        current_index = DIRS.size + current_index
    else
        current_index %= DIRS.size
    end

    return DIRS[current_index]
end

# move accepts a location and a direction of travel and returns the new location
def move(location, direction)
    return [location[0] + direction[0], location[1] + direction[1]]
end

def main
    input = File.read("input.txt")
    instructions = input.split(', ')

    # location is a cartesian coordinate representing where the user is standing
    location = [0, 0]
    # facing represents the direction the user is currently facing
    facing = NORTH
    visited = {}
    hq = nil

    instructions.each do |instruction|
        rotate = instruction[0]
        distance = instruction[1..-1].to_i
        facing = turn(facing, rotate)
        dirname = case facing
                  when NORTH then 'North'
                  when EAST then 'East'
                  when SOUTH then 'South'
                  when WEST then 'West'
                  end
        puts "Turned #{rotate}, now facing #{dirname}"
        distance.times do
            location = move(location, facing)
            puts"Now at #{location}"
            if visited[location] && !hq
                hq = location
                puts "Found hq at #{location}"
            else
                visited[location] = true
            end
        end
    end

    puts "Directions end at location #{location} for a minimum taxicab distance of #{location[0].abs + location[1].abs}"
    puts "HQ at location #{hq} for a minimum taxicab distance of #{hq[0].abs + hq[1].abs}"
end
main
