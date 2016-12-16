#!/usr/bin/env ruby

# move takes a current digit and a direction of motion and returns the next digit
def move(where, direction)
    case direction
    when 'U'
        case where
        when 1..3 then return where
        when 4..9 then return where - 3
        end
    when 'D'
        case where
        when 1..6 then return where + 3
        when 7..9 then return where
        end
    when 'L'
        case where
        when 1, 4, 7 then return where
        when 2, 3, 5, 6, 8, 9 then return where - 1
        end
    when 'R'
        case where
        when 3, 6, 9 then return where
        when 1, 2, 4, 5, 7, 8 then return where + 1
        end
    else
        return where
    end
end

# move2 does the same as move, but with a differently-shaped keypad
def move2(where, direction)
    case direction
    when 'U'
        case where
        when 5, 2, 1, 4, 9 then return where
        when 3 then return 1
        when 6..8 then return where - 4
        when 'A' then return 6
        when 'B' then return 7
        when 'C' then return 8
        when 'D' then return 'B'
        end
    when 'D'
        case where
        when 1 then return 3
        when 2..4 then return where + 4
        when 6 then return 'A'
        when 7 then return 'B'
        when 8 then return 'C'
        when 'B' then return 'D'
        when 5, 'A', 'D', 'C', 9 then return where
        end
    when 'L'
        case where
        when 1, 2, 5, 'A', 'D' then return where
        when 3..4, 6..9 then return where - 1
        when 'B' then return 'A'
        when 'C' then return 'B'
        end
    when 'R'
        case where
        when 1, 4, 9, 'C', 'D' then return where
        when 2..3, 5..8 then return where + 1
        when 'A' then return 'B'
        when 'B' then return 'C'
        end
    else
        return where
    end
end

# process takes a multi-line string input and produces the door code
def process(input, movefunc)
    current_code = ""
    lines = input.split("\n")
    current_digit = 5
    lines.each do |line|
        line.strip!
        line.each_char do |c|
            new_digit = send(movefunc, current_digit, c)
            puts "Want to go #{c} from #{current_digit}, new location is #{new_digit}"
            current_digit = new_digit
        end
        current_code << current_digit.to_s
    end
    return current_code
end

def test
    input = <<-END
        ULL
        RRDDD
        LURDL
        UUUUD
        END
    result = process(input, :move)
    if result == '1985'
        puts "Success!"
    else
        raise "Expected 1985 but got #{result.inspect}"
    end

    result = process(input, :move2)
    if result == '5DB3'
        puts "Success!"
    else
        raise "Expected 5DB3 but got #{result.inspect}"
    end
end

def main
    input = File.read('input.txt')
    puts "1: #{process(input, :move)}"
    puts "2: #{process(input, :move2)}"
end

test
main
