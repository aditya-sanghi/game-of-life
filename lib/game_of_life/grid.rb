module GameOfLife
  class  Grid
    attr_reader :number_of_generations, :cells_visited, :cell_array, :new_array

    def initialize(height, width, number_of_generations, output_file = File.open("output.txt", "w"))
      @output_file = output_file
      @height, @width = height, width
      @cell_array = Array.new(height) { Array.new(width) { GameOfLife::Cell.new(Cell::DEAD) } }
      @new_array = Array.new(height) { Array.new(width) { GameOfLife::Cell.new(Cell::DEAD) } }

      initial_config
      @number_of_generations = next_generation_creator(number_of_generations)
    end

    def initial_config
      [[2, 3], [2, 4], [2, 5]].each do |(x, y)|
        @cell_array[x][y].revive!
      end
    end

    def next_generation_creator(number_of_generations)
      temp = 0
      while temp.to_i < number_of_generations.to_i do
        next_generation
        temp = temp + 1
      end
      temp
    end

    def make_linear
      @cell_array.flatten
    end

    def next_generation
      temp = 0
      @cell_array.each_index do |i|
        subarray = @cell_array[i]
        subarray.each_index do |j|
          temp = temp + 1
          game_rules(i, j)
        end
      end
      @output_file.write "\nDisplaying Result of the latest generation!"
      display
      @cells_visited = temp.to_i
    end

    def alive_neighbour_count(x, y)
      all_neighbour_coordinates = [[-1, 0], [1, 0], [-1, 1], [0, 1], [1, 1], [-1, -1], [0, -1], [1, -1]]
      all_neighbour_coordinates.inject(0) do |sum, pos|
        sum + (@cell_array[(x + pos[0]) % @height][(y + pos[1]) % @width].alive? ? 1 : 0)
      end
    end

    def game_rules(x, y)
      alive_neighbour_count = alive_neighbour_count(x, y)
      if @cell_array[x][y].alive?
        if (alive_neighbour_count != 2 && alive_neighbour_count != 3)
          @new_array[x][y].kill!
        else
          @new_array[x][y].revive!
        end
      else
        if alive_neighbour_count == 3
          @new_array[x][y].revive!
        end
      end
    end

    def display
      alive = "A"
      dead = "-"
      @new_array.each_index do |i|
        @output_file.write "\n"
        subarray = @new_array[i]
        subarray.each_index do |j|
          if @new_array[i][j].alive?
            @output_file.write alive
            @cell_array[i][j].revive!
          else
            @output_file.write dead
            @cell_array[i][j].kill!
          end
        end
      end
    end

    private :initial_config
  end
end

