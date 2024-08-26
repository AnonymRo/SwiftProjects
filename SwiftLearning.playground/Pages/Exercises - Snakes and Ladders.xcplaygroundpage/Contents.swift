/*:
 # Snakes and Ladders
 */
/* Using a while loop */
let finalCount = 25
var board = [Int](repeating: 0, count: finalCount + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

var currentPosition = 0
var diceRoll = 0
while currentPosition < finalCount {
    //roll the dice
    diceRoll += 1
    //diceRoll can only be 1,2,3,4,5 or 6
    if diceRoll == 7 { diceRoll = 1 }
    //move by the rolled amount
    currentPosition += diceRoll
    if currentPosition < board.count {
        //if we are still on the board, move up or down for a snake or a ladder
        currentPosition += board[currentPosition]
    }
}
print("Game over!")

/* Using a repeat-while loop */
board = [Int](repeating: 0, count: finalCount + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08

currentPosition = 0
diceRoll = 0

repeat {
    //move up or down for a snake or a ladder
    currentPosition += board[currentPosition]
    //roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    //move by the rolled amount
    currentPosition += diceRoll
} while currentPosition < finalCount
print("Game over!")

/* Using labe statements */
board = [Int](repeating: 0, count: finalCount + 1)

board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -0

currentPosition = 0
diceRoll = 0

gameLoop: while currentPosition != finalCount {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch currentPosition + diceRoll {
        //diceRoll will bring us to the final position, so the game is over
    case finalCount:
        break gameLoop
        //diceRoll will move us beyond the final position, so the game continues in order to roll again
    case let newPosition where newPosition > finalCount:
        continue gameLoop
    default:
        //valid move
        currentPosition += diceRoll
        currentPosition += board[currentPosition]
    }
}
print("Game over!")
