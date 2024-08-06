/*: [Previous](@previous)             [Next](@next)

 
 - Experiment: Write a function that compares two Rank values by comparing their raw values. Also add a color() method to Suit that returns “black” for spades and clubs, and returns “red” for hearts and diamonds.
 
 */
enum Rank: Int {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king

    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

enum Suits: Int {
    case spades
    case clubs
    case hearts
    case diamonds
    
    func color() -> String {
        switch self {
        case .spades, .clubs:
            return "black"
        case .hearts, .diamonds:
            return "red"
        }
    }
}

let queen = Rank.queen
let aceRawValue = queen.rawValue

func compareRawValues(_ firstValue: Rank, _ secondValue: Rank) -> Bool {
    return firstValue.rawValue == secondValue.rawValue
}

let two = Rank.two
let king = Rank.king

print(compareRawValues(two, king))  //Prints "false"
print(compareRawValues(king, king)) //Prints "true"

let spades = Suits.spades
let hearts = Suits.hearts

print(spades.color())   //Prints "black"
print(hearts.color())   //Prints "red"
