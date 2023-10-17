mutable struct CheckersBoard
    const EMPTY = 0
    const BLACK = 1
    const RED = 2
    board::Matrix{Int}

    function CheckersBoard()
        # Initialize an 8x8 board with pieces in their initial positions
        board = fill(EMPTY, 8, 8)
        for row in 1:3
            for col in 1:8
                if (row + col) % 2 == 0
                    board[row, col] = BLACK
                end
            end
        end
        for row in 6:8
            for col in 1:8
                if (row + col) % 2 == 0
                    board[row, col] = RED
                end
            end
        end
        new(board)
    end
end

function move(board::CheckersBoard, x1::Int, y1::Int, x2::Int, y2::Int)::Bool
    # Check if the move is within bounds
    if !(1 <= x1 <= 8 && 1 <= y1 <= 8 && 1 <= x2 <= 8 && 1 <= y2 <= 8)
        return false
    end

    # Check if the target square is empty
    if board.board[x2, y2] != CheckersBoard.EMPTY
        return false
    end

    # Determine the direction of the move based on piece color
    direction = (board.board[x1, y1] == CheckersBoard.BLACK) ? 1 : -1

    # Check if it's a basic move (one square diagonally)
    if abs(x2 - x1) == 1 && abs(y2 - y1) == 1
        # Move the piece to the target square
        board.board[x2, y2] = board.board[x1, y1]
        board.board[x1, y1] = CheckersBoard.EMPTY
        return true
    end

    # Check if it's a capture move (jumping over an enemy piece)
    if abs(x2 - x1) == 2 && abs(y2 - y1) == 2
        enemy_x = div(x1 + x2, 2)
        enemy_y = div(y1 + y2, 2)

        # Check if there's an enemy piece to capture
        if board.board[enemy_x, enemy_y] != (3 - board.board[x1, y1])
            return false
        end

        # Move the piece to the target square and remove the captured piece
        board.board[x2, y2] = board.board[x1, y1]
        board.board[x1, y1] = CheckersBoard.EMPTY
        board.board[enemy_x, enemy_y] = CheckersBoard.EMPTY
        return true
    end

    return false
end

function count(board::CheckersBoard, color::Int)::Int
    # Count the number of pieces of the specified color on the board
    return sum(board.board .== color)
end

function display(board::CheckersBoard)
    # Display the board and its current contents in ASCII art
    for row in board.board
        println(join([piece == CheckersBoard.EMPTY ? "  " : piece == CheckersBoard.BLACK ? "B " : "R " for piece in row]))
    end
end

# Example usage:
board = CheckersBoard()
display(board)
println(move(board, 2, 1, 3, 2))  # Move a black piece diagonally
display(board)
println(move(board, 5, 2, 4, 3))  # Move a red piece diagonally
display(board)
println(move(board, 3, 2, 5, 4))  # Attempt an invalid move
display(board)
println(move(board, 3, 2, 4, 3))  # Capture a red piece
display(board)
println("Black pieces:", count(board, CheckersBoard.BLACK))
println("Red pieces:", count(board, CheckersBoard.RED))
