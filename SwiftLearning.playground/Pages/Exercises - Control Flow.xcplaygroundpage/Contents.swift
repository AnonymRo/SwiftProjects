/*:
 # Control Flow
 */
/* For loops */
let cats: [String] = ["Tom", "Billy", "Mittens"]
for cat in cats {
    print("Hello, \(cat)!")
}

/* For loop in a tuple */
let numberOfLegs = ["Spider": 8, "Ant": 6, "Dog": 4]
for (animalName, legsCount) in numberOfLegs {
    print("\(animalName)s have \(legsCount) legs.")
}

/* For loop with a numeric range */
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}

let minutes = 60
for minute in 0..<minutes {
    //render the tick mark each minute (60 times)
}

let minuteInterval = 5
for minute in stride(from: 0, to: minutes, by: minuteInterval) {
    //render the tick mark every 5 minute (0, 5, 10, 15, ... )
}

let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    //render the tick mark every 3 hours (3, 6, 9, 12)
}

/* If statement */
let temperatureInFahrenheit: Int = 90
if temperatureInFahrenheit <= 32 {
    print("It's too cold.")
} else if temperatureInFahrenheit >= 86 {
    print("It's actually warm outside. Use sunscreen.")
} else {
    print("It's not that cold outside. Enjoy your day.")
}

let temperatureInCelsius: Int = 24
let weatherAdvice = if temperatureInCelsius <= 0 {
    "It's too cold. Wear a jacket."
} else if temperatureInCelsius >= 30 {
    "It's hot outside. Drink plenty of water."
} else {
    "It's not that cold outside. Enjoy your day."
}
print(weatherAdvice)

let freezeWarning: String? = if temperatureInCelsius <= 0 {
    "Watch out for ice!"
} else {
    nil     //Here, you can provide an explicit type for nil instead of freezeWarning: nil as String?
}

/* Switch statements */
let someCharacter: Character = "z"
switch someCharacter {
case "a":
    print("The first letter of the latin alphabet")
case "z":
    print("The last letter of the latin alphabet")
default:
    print("Some other letter")
}

let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a":
    "The first letter of the latin alphabet"
case "z":
    "The last letter of the latin alphabet"
default:
    "Some other letter"
}
print(message)

/* Interval matching */
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount = switch approximateCount {
case 0:
    "no"
case 1..<5:
    "a few"
case 5..<12:
    "several"
case 12..<100:
    "dozens of"
case 100..<1000:
    "hundres of"
default:
    "many"
}
print("There are \(naturalCount) \(countedThings) in our solar system.")

/* Tuples */
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin.")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside the box")
}

/* Value binding */
let anotherPoint = (2, 2)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with the value x of \(x)")
case (0, let y):
    print("on the y-axis with the value y of \(y)")
case (let x, let y):
    print("Somewhere else on the graph with the values x of \(x) and y of \(y)")
}

/* Where clause */
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case (let x, let y) where x == y:
    print("\(x), \(y) is on the line x == y")
case (let x, let y) where x == -y:
    print("\(x), \(y) is on the line x == -y")
case (let x, let y):
    print("\(x), \(y) is an arbitrary point")
}

/* Compound cases */
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
case (let distance, 0), (0, let distance):
    print("On an axis, \(distance) from the origin")
default:
    print("Not on an axis")
}

/* Control transfer statements - Continue */
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]

for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}

/* Control transfer statements - Break */
let numberSymbol: Character = "三" //Chinese character for number 3
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}

if let anIntegerValue = possibleIntegerValue {
    print("\(numberSymbol) has a value of \(anIntegerValue)")
} else {
    print("\(numberSymbol) doesn't have an integer value")
}

/* Control transfer statements - Fallthrough */
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 13:
    description += " a prime number and also"
    fallthrough
default:
    description += " an integer"
}

/* Early exit - Guard statement */
func greet(person: [String: String]) -> Void {
    guard let name = person["name"] else {
        return
    }
    print("Hello, \(name)")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

greet(person: ["name": "John"])
greet(person: ["name" : "Jane", "location" : "Cupertino"])

/* Deffered actions */
