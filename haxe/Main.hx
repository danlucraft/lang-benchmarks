class Main {
	static public function count_taken_in_direction_from(board:Array<Array<String>>, i:Int, j:Int, di:Int, dj:Int) {
		var i = i + di;
		var j = j + dj;
		var count = 0;

		while (in_board(board, i, j) && board[i][j] == "b") {
			count += 1;
			i += di;
			j += dj;
		}

		if (in_board(board, i, j) && board[i][j] == "w") {
			return count;
		} else {
			return 0;
		}
	}

	static public function in_board(board, i, j) {
		return i > 0 && j > 0 && i < 8 && j < 8;
	}

	static public function take_count_at(board:Array<Array<String>>, i:Int, j:Int):Int {
		var take_count:Int = 0;
		for (di in -1...2) {
			for (dj in -1...2) {
				if (di != 0 || dj != 0) {
					take_count += count_taken_in_direction_from(board, i, j, di, dj);
				}
			}
		}
		return take_count;
	}

	static public function main():Void {
		var content:String = sys.io.File.getContent('../reversi/reversi.txt');
		var board = [for (line in content.split("\n")) line.split("")];
		var best_move = [0, 0];
		var best_take_count = -1;
		for (x in 0...100000) {
			best_move = [0, 0];
			best_take_count = -1;
			for (i in 0...board.length) {
				var row = board[i];
				for (j in 0...row.length) {
					var cell = row[j];
					if (cell == ".") {
						var take_count = take_count_at(board, i, j);
						if (take_count > best_take_count) {
							best_move = [i, j];
							best_take_count = take_count;
						}
					}
				}
			}
		}
		trace([best_move, best_take_count]);
	}
}
