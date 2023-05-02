Rails.application.routes.draw do
  root 'sudoku#index'
  post 'sudoku/index'
  get 'sudoku/index'
end