require 'spec_helper'

module GameOfLife

  describe Grid do
    it 'initialising a grid' do
      grid = Grid.new(100, 100, 3)
      expect(grid.make_linear.length).to eq(10000)
    end

    describe '#alive_neighbour_count(x,y)' do
      it 'should return the correct number of alive neighbors if 3 surrounding neighbors are alive' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[0][0]).revive!
        (grid.cell_array[1][2]).revive!
        (grid.cell_array[0][2]).revive!
        expect(grid.alive_neighbour_count(1, 1)).to eq(3)
      end

      it 'should return the correct number of alive neighbors if no neighbour is alive' do
        grid = Grid.new(100, 100, 1)
        expect(grid.alive_neighbour_count(1, 1)).to eq(0)
      end

      it 'should return the correct number of alive neighbors if 8 surrounding neighbors are alive' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[0][0]).revive!
        (grid.cell_array[1][2]).revive!
        (grid.cell_array[0][2]).revive!
        (grid.cell_array[0][1]).revive!
        (grid.cell_array[2][0]).revive!
        (grid.cell_array[1][0]).revive!
        (grid.cell_array[2][1]).revive!
        (grid.cell_array[2][2]).revive!
        expect(grid.alive_neighbour_count(1, 1)).to eq(8)
      end
    end

    describe '#game_rules' do
      it 'should make dead cell with 3 alive neighbors alive' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[0][0]).revive!
        (grid.cell_array[0][1]).revive!
        (grid.cell_array[0][2]).revive!

        grid.game_rules(1, 1)
        expect(grid.new_array[1][1]).to be_alive
      end

      it 'should keep a dead cell with 2 alive neighbors dead' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[0][0]).revive!
        (grid.cell_array[0][1]).revive!

        grid.game_rules(1, 1)
        expect(grid.new_array[1][1]).to be_dead
      end

      it 'should keep111 an alive cell with 2 alive neighbors alive' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[1][1]).revive!
        (grid.cell_array[0][0]).revive!
        (grid.cell_array[0][1]).revive!


        grid.game_rules(1, 1)
        expect(grid.new_array[1][1]).to be_alive
      end

      it 'should keep an alive cell with 3 alive neighbors alive' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[1][1]).revive!

        (grid.cell_array[0][0]).revive!
        (grid.cell_array[0][1]).revive!
        (grid.cell_array[0][2]).revive!


        grid.game_rules(1, 1)
        expect(grid.new_array[1][1]).to be_alive
      end

      it 'should make an alive cell with 5 alive neighbors dead' do
        grid = Grid.new(100, 100, 1)
        (grid.cell_array[1][1]).revive!

        (grid.cell_array[0][0]).revive!
        (grid.cell_array[0][1]).revive!
        (grid.cell_array[0][2]).revive!
        (grid.cell_array[1][2]).revive!
        (grid.cell_array[2][2]).revive!

        grid.game_rules(1, 1)
        expect(grid.new_array[1][1]).to be_dead
      end
    end

    describe '#next_generator_creator' do
      it 'should stop after given number of generations!' do
        grid = Grid.new(100, 100, 3)
        number_of_generations = grid.number_of_generations
        expect(number_of_generations).to eq(3)
      end
    end

    describe '#next_generation' do
      it 'should go over all the cells in the grid during each generation' do
        grid = Grid.new(100, 100, 3)
        cells_visited=grid.cells_visited
        expect(cells_visited).to eq(10000)
      end
    end


    describe '#initial_config' do
      it 'should make the appropriate cells alive initially' do
        grid = Grid.new(9, 9, 10)
        expect(grid.new_array[2][3]).to be_alive
        expect(grid.new_array[2][4]).to be_alive
      end
    end

  end
end
