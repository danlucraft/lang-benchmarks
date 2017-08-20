import strutils, sequtils

let data = readFile("reversi/reversi.txt")
let lines = splitLines(data)

type
  BoardArray = array[8, array[8, char]]

var board: BoardArray
var i = 0
var j = 0
for line in lines:
  j = 0
  for c in line:
    board[i][j] = c
    j = j + 1
  i = i + 1

var best_move = [-1, -1]
var best_take_count = -1

proc in_board(board: BoardArray, i: int, j: int): bool =
  let h = board.len
  let w = board[0].len
  result = i > 0 and j > 0 and i < h and j < w

proc count_taken_in_direction_from(board: BoardArray, i_in: int, j_in: int, di: int, dj: int): int = 
  var i = i_in + di
  var j = j_in + dj
  var count = 0
  
  while in_board(board, i, j) and board[i][j] == 'b':
    count += 1
    i = i + di
    j = j + dj
  
  if in_board(board, i, j) and board[i][j] == 'w':
    result = count
  else:
    result = 0

proc take_count_at(board: BoardArray, i: int, j: int): int = 
  result = count_taken_in_direction_from(board, i, j, -1, -1) + 
    count_taken_in_direction_from(board, i, j, -1, 0) + 
    count_taken_in_direction_from(board, i, j, -1, 1) + 
    count_taken_in_direction_from(board, i, j, 0, -1) + 
    count_taken_in_direction_from(board, i, j, 0, 1) + 
    count_taken_in_direction_from(board, i, j, 1, -1) + 
    count_taken_in_direction_from(board, i, j, 1, 0) + 
    count_taken_in_direction_from(board, i, j, 1, 1)

for i in countup(0, 7):
  for j in countup(0, 7):
    let cell = board[i][j]
    if cell == '.':
      var take_count = 0
      for _ in countup(1, 100000):
        take_count = take_count_at(board, i, j)
      if take_count > best_take_count:
        best_move = [i, j]
        best_take_count = take_count

echo best_move[0]
echo best_move[1]
echo best_take_count
