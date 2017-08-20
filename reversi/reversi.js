var fs = require('fs')

let data = fs.readFileSync("./reversi/reversi.txt").toString("ascii")
let lines = data.split("\n")
let board = lines.map(function(line) { return line.split("") } )

var bestMove = null
var bestTakeCount = -1

var in_board = function(board, i, j) {
  let h = board.length
  let w = board[0].length
  return i > 0 && j > 0 && i < h && j < w
}

var countTakenInDirectionFrom = function(board, i, j, di, dj) {
  var i = i + di
  var j = j + dj
  var count = 0
  while (in_board(board, i, j) && board[i][j] === 'b') {
    count += 1
    i = i + di
    j = j + dj
  }
  
  if (in_board(board, i, j) && board[i][j] === 'w')
    return count
  else
    return 0
}

var takeCountAt = function(board, i, j) {
  return(
    countTakenInDirectionFrom(board, i, j, -1, -1) + 
    countTakenInDirectionFrom(board, i, j, -1, 0) + 
    countTakenInDirectionFrom(board, i, j, -1, 1) + 
    countTakenInDirectionFrom(board, i, j, 0, -1) + 
    countTakenInDirectionFrom(board, i, j, 0, 1) + 
    countTakenInDirectionFrom(board, i, j, 1, -1) + 
    countTakenInDirectionFrom(board, i, j, 1, 0) + 
    countTakenInDirectionFrom(board, i, j, 1, 1)
  )
}

var i = 0
board.forEach(function(row) {
  var j = 0
  row.forEach(function(cell) { 
    if (cell === ".") {
      var takeCount = 0
      for (var x = 0; x < 100000; x++) {
        takeCount = takeCountAt(board, i, j)
      }
      if (bestMove === null || takeCount > bestTakeCount) {
        bestMove = [i, j]
        bestTakeCount = takeCount
      }
    }
    j++
  })
  i++
})

console.log(bestMove, bestTakeCount)