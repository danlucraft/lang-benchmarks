use std::fs;

type Board<'a> = Vec<Vec<&'a str>>;

fn main() {
    let board_string = fs::read_to_string("reversi/reversi.txt").expect("couldn't load board");
    let lines: Vec<&str> = board_string.split("\n").collect();
    let mut board: Vec<Vec<&str>> = vec![];
    for line in lines {
        let cells: Vec<&str> = line.split("").collect();
        let mut row: Vec<&str> = vec![];
        for cell in cells {
            if cell != "" {
                row.push(cell);
            }
        }
        board.push(row);
    }
    let mut i = 999999;
    while i > 0 {
        best_move(&board);
        i = i - 1;
    }
    let (best_take_count, best_x, best_y) = best_move(&board);
    println!("best is ({}, {}) taking {} pieces", best_x, best_y, best_take_count);
}

fn best_move(board: &Board) -> (i64, i64, i64) {
    let mut best_take_count = 0;
    let mut best_x = 0;
    let mut best_y = 0;

    for y in 0..8 {
        for x in 0..8 {
            if board[y as usize][x as usize] == "." {
                let c = take_count_at(x, y, &board);
                if c > best_take_count {
                    best_take_count = c;
                    best_x = x;
                    best_y = y;
                }
            }
        }
    }
    (best_take_count, best_x, best_y)
}

fn take_count_at(x: i64, y: i64, board: &Board) -> i64 {
    take_count_at_in_direction(x, y, board,     -1, -1) + 
        take_count_at_in_direction(x, y, board, -1,  0) + 
        take_count_at_in_direction(x, y, board, -1,  1) + 
        take_count_at_in_direction(x, y, board,  0, -1) + 
        take_count_at_in_direction(x, y, board,  0,  1) + 
        take_count_at_in_direction(x, y, board,  1, -1) + 
        take_count_at_in_direction(x, y, board,  1,  0) + 
        take_count_at_in_direction(x, y, board,  1,  1)
}

fn take_count_at_in_direction(x: i64, y: i64, board: &Board, dx: i64, dy: i64) -> i64 {
    let mut white_count = 0;
    let mut x1 = x + dx;
    let mut y1 = y + dy;

    if x1 < 0 || y1 < 0 || x1 > 7 || y1 > 7 {
        return 0;
    }
    while board[y1 as usize][x1 as usize] == "w" {
        white_count = white_count + 1;
        x1 = x1 + dx;
        y1 = y1 + dy;
        if x1 < 0 || y1 < 0 || x1 > 7 || y1 > 7 {
            return 0;
        }
    }
    if board[y1 as usize][x1 as usize] == "b" {
        white_count
    } else {
        0
    }
}



