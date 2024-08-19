/*:
 # Strings and charaters
 */
/* Special characters in string literals */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
print(wiseWords)

let dollarSign = "\u{24}"       //$, Unicode scalar U+0024
let blackHeart = "\u{2665}"     //🖤, Unicode scalar U+2265

let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
print(threeDoubleQuotationMarks)

/* Extended string delimiters */
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
print(threeMoreDoubleQuotationMarks)

/* Initializing an empty string */
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("This string is empty")
}

/* String mutability */
var variableString = "The horse is "
variableString += "far away from us."
print(variableString)

/* Concatenating strings */
let string1 = "Hello, "
let string2 = "world"
var concatenatedString = string1 + string2

let giraffe = "Giraffes are tall."
print(giraffe[giraffe.startIndex])

/* Appending a Character value to a string */
let character: Character = "!"
concatenatedString.append(character)
print(concatenatedString)

/* String interpolation */
let number = 3
let stringInterpolation = "\(number) times 2.5 is \(Double(number) * 2.5)"

/* Unicode scalars */
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"

/* Counting Characters */
let text: String = "This is a string!🐻"
print("This text has \(text.count) characters.")

/* String indices */
let greeting = "Hello there"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 4)
greeting[index]

for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
}

/* Insert and removing */
var welcome: String = "Hello"
welcome.insert("!", at: welcome.endIndex)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
welcome.remove(at: welcome.index(before: welcome.endIndex))
let range = welcome.index(welcome.endIndex, offsetBy: -5)..<welcome.endIndex
welcome.removeSubrange(range)

/* Substrings */
let greet: String = "Hello, world!"
let indexOfGreet = greet.firstIndex(of: ",") ?? greet.endIndex
let subString = greet[..<indexOfGreet]

let newString = String(subString)

/* Comparing strings */
let quotation1 = "The world is nice!"
let quotation2 = "The world is nice!"

if quotation1 == quotation2 {
    print("\nThe quotations are equal.")
}

/* Prefix and Sufix */
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var act1SceneCount: Int = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1 ") {
        act1SceneCount += 1
    }
}
print("\nThere are \(act1SceneCount) scenes in Act 1.")
