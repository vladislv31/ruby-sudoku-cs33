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
    return false
  end

  def sudoku_solved?(grid)
    return 1
  end
end