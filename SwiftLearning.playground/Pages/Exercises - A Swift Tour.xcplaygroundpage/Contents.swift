/*:
 ## Swift exercises
 
 - Experiment:
 Make another subclass of NamedShape called Circle that takes a radius and a name as arguments to its initializer. \
 Implement an area() and a simpleDescription() method on the Circle class.
 */
import Foundation

class NamedShape {
    var numberOfSides: Int = 0
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides."
    }
}

class Circle: NamedShape {
    var circleRadius: Int = 0
    let pi: Double = 3.14
    
    init(circleRadius: Int, name: String) {
        self.circleRadius = circleRadius
        super.init(name: name)
    }
    
    func area() -> Double {
        let radius = Double(circleRadius)
        return pi * pow(radius, 2)
    }
    
    override func simpleDescription() -> String {
        return "A circle with the radius of \(circleRadius) has an area of \(area())."
    }
}

let test = Circle(circleRadius: 5, name: "My test circle")
test.area()
test.simpleDescription()


/*:
 - Experiment: Write a function that compares two Rank values by comparing their raw values. Also add a color() method to Suit that returns “black” for spades and clubs, and returns “red” for hearts and diamonds. Write a function that returns an array containing a full deck of cards, with one card of each combination of rank and suit.
 
 */
enum Rank: Int, CaseIterable {
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

enum Suits: Int, CaseIterable {
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

struct Card {
    let rank: Rank
    let suits: Suits
    
    func simpleDescription() -> String {
        return "\(rank.simpleDescription()) of \(suits)"
    }
}

func fullDeck() -> [Card] {
    var deck: [Card] = []
    for rank in Rank.allCases {
        for suit in Suits.allCases {
            deck.append(Card(rank: rank, suits: suit))
        }
    }
    return deck
}

let deck = fullDeck()
for card in deck {
    print(card.simpleDescription())
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
/*:
 
 - Experiment: Add a third case to ServerResponse and to the switch.
 
 */
enum ServerResponse {
    case result(String, String)
    case outOfSync(String)
    case failure(String)
}


let success = ServerResponse.result("6:00 am", "8:09 pm")
let outOfSync = ServerResponse.outOfSync("Out of sync")
let failure = ServerResponse.failure("Out of cheese.")


switch success {
case let .result(sunrise, sunset):
    print("Sunrise is at \(sunrise) and sunset is at \(sunset).")
case let .outOfSync(message):
    print("The server is \(message)")
case let .failure(message):
    print("Failure...  \(message)")
}


/*:
 
 - Experiment: Add another requirement to ExampleProtocol. What changes do you need to make to SimpleClass and SimpleStructure so that they still conform to the protocol?
 
 */
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class."
    var secondRequirement: Int = 10
    var anotherProperty: Int = 69105
    func adjust() {
        simpleDescription += "  Now \(secondRequirement)% adjusted."
    }
}
var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription
print(aDescription)

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    var secondRequirement: Int = 20
    mutating func adjust() {
        simpleDescription += " (\(secondRequirement)% adjusted)"
    }
}
var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription
print(bDescription)



extension Int: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    mutating func adjust() {
        self += 42
    }
}
print(7.simpleDescription)

/*:
 
 - Experiment: Write an extension for the Double type that adds an absoluteValue property.
 
 */
extension Double: ExampleProtocol {
    var simpleDescription: String {
        return "The number \(self)"
    }
    var absoluteValue: Double {
        return self < 0 ? -self : self
    }
    mutating func adjust() {
        self += 22
    }
}

let absoluteNumber: Double = -42.0
print(absoluteNumber.absoluteValue, terminator: "")
