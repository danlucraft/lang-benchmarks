board = File.readlines("reversi/reversi.txt")
board = board.map {|row| row.split("")}


def count_taken_in_direction_from(board, i, j, di, dj)
  i += di
  j += dj
  count = 0

  while in_board?(board, i, j) && board[i][j] == "b"
    count += 1
    i += di
    j += dj
  end

  if in_board?(board, i, j) && board[i][j] == "w"
    count
  else
    0
  end
end

def in_board?(board, i, j)
  h = board.size
  w = board[0].size
  i > 0 && j > 0 && i < h && j < w
end

def take_count_at(board, i, j)
  count_taken_in_direction_from(board, i, j, -1, -1) + 
  count_taken_in_direction_from(board, i, j, -1, 0) + 
  count_taken_in_direction_from(board, i, j, -1, 1) + 
  count_taken_in_direction_from(board, i, j, 0, -1) + 
  count_taken_in_direction_from(board, i, j, 0, 1) + 
  count_taken_in_direction_from(board, i, j, 1, -1) + 
  count_taken_in_direction_from(board, i, j, 1, 0) + 
  count_taken_in_direction_from(board, i, j, 1, 1)
end

best_move = nil
best_take_count = -1
100000.times do
  best_move = nil
  best_take_count = -1
  
  board.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if cell == "."
        take_count = take_count_at(board, i, j)
        if take_count > best_take_count
          best_move = [i, j]
          best_take_count = take_count
        end
      end
    end
  end
end

p best_move
p best_take_count
