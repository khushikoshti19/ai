board = [" "] * 9


def print_board(b):
    print(f"\n {b[0]} | {b[1]} | {b[2]} ")
    print("-----------")
    print(f" {b[3]} | {b[4]} | {b[5]} ")
    print("-----------")
    print(f" {b[6]} | {b[7]} | {b[8]} \n")


def check_win(b, p):
    wins = [
        (0, 1, 2),
        (3, 4, 5),
        (6, 7, 8),
        (0, 3, 6),
        (1, 4, 7),
        (2, 5, 8),
        (0, 4, 8),
        (2, 4, 6)
    ]

    return any(b[i] == b[j] == b[k] == p for i, j, k in wins)


def minimax(b, is_max):
    if check_win(b, "O"):
        return 1

    if check_win(b, "X"):
        return -1

    if " " not in b:
        return 0

    if is_max:
        best = -99

        for i in range(9):
            if b[i] == " ":
                b[i] = "O"
                best = max(best, minimax(b, False))
                b[i] = " "

        return best

    else:
        best = 99

        for i in range(9):
            if b[i] == " ":
                b[i] = "X"
                best = min(best, minimax(b, True))
                b[i] = " "

        return best


def ai_best_move(b):
    val, move = -99, -1

    for i in range(9):
        if b[i] == " ":
            b[i] = "O"
            score = minimax(b, False)
            b[i] = " "

            if score > val:
                val, move = score, i

    return move


def play_game():
    print("========================================")
    print("       O vs X GAME (TIC-TAC-TOE)")
    print("========================================")
    print("You are X. The AI is O.")
    print("Positions are numbered 0 to 8:")
    print(" 0 | 1 | 2 ")
    print("-----------")
    print(" 3 | 4 | 5 ")
    print("-----------")
    print(" 6 | 7 | 8 \n")

    while True:
        print_board(board)

        try:
            move = int(input("Enter your move (0-8): "))

            if move < 0 or move > 8 or board[move] != " ":
                print("Invalid move! Choose an empty spot between 0 and 8.")
                continue

        except ValueError:
            print("Please enter a valid integer number!")
            continue

        board[move] = "X"

        if check_win(board, "X"):
            print_board(board)
            print("Congratulations, you win!")
            break

        if " " not in board:
            print_board(board)
            print("It's a tie!")
            break

        print("AI (O) is thinking...")
        ai_move = ai_best_move(board)
        board[ai_move] = "O"

        if check_win(board, "O"):
            print_board(board)
            print("AI (O) wins! Better luck next time.")
            break

        if " " not in board:
            print_board(board)
            print("It's a tie!")
            break


if __name__ == "__main__":
    play_game()
