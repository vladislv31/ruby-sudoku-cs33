class SudokuController < ApplicationController
  def index
    @solution = Array.new(9) { Array.new(9, 0) }
    if request.post?
      @sudoku = params[:sudoku].to_unsafe_h.values.map { |row| row.values.map(&:to_i) }
      if params.keys.include? 'solve'
        @solved_sudoku = solve_sudoku(@sudoku)
        if !@solved_sudoku
          @solution = @sudoku
          @cantSolve = true
        elsif @solved_sudoku == true
          @solution = @sudoku
        else
          @solution = @solved_sudoku
        end
      else
        @solution = @sudoku
        @isSolved = sudoku_solved?(@sudoku)
      end
    end
  end

  private

def solve_sudoku(grid)
    find = find_empty_cell(grid)
    return true if !find
  
    row, col = find
  
    (1..9).each do |num|
      if valid?(grid, row, col, num)
        grid[row][col] = num
  
        if solve_sudoku(grid)
          return grid
        end
        grid[row][col] = 0
      end
    end

    return false
  end
  
  def find_empty_cell(grid)
    grid.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == 0
          return [i, j]
        end
      end
    end
    return nil
  end

  def valid?(grid, row, col, num)
    for i in 0..8
      if grid[row][i] == num
        return false
      end
    end
  
    for i in 0..8
      if grid[i][col] == num
        return false
      end
    end
  
    box_row = (row / 3) * 3
    box_col = (col / 3) * 3
    for i in 0..2
      for j in 0..2
        if grid[box_row + i][box_col + j] == num
          return false
        end
      end
    end
  
    return true
  end

  def sudoku_solved?(grid)
    return 1
  end
end
