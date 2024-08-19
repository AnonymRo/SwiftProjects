/*:
 # The Basics
 */

/* Boundaries for UInt8 */
let minValue = UInt8.min
let maxValue = UInt8.max

/* Float represents a 32-bit floating-point number */
let floatValue: Float = 3.14
/* Double represents a 64-bit floating-point number */
let doubleValue: Double = 10.0

/* Numeric literals */
let decimalInteger = 17
let binaryInteger = 0b10001     //17 in binary
let octalInteger = 0o21         //17 in octal
let hexadecimalInteger = 0x11   //17 in hexa

/* Decimal and hexadecimal exponent #<e># , #<p># */
let decimalExponent = 125e2
let hexadecimalExponent = 0xFp2

/* Integer conversions */
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)

/* Floating-point conversions */
let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine
let integerPi = Int(pi)

/* Type Alias */
typealias AudioSample = UInt16
var maxAmplitute: AudioSample = 0

/* Booleans */
let skyIsBlue = true
let swiftIsHard = false

if skyIsBlue {
    print("What a beautiful day!")
}
else {
    print("No, it's not!")
}

/* Tuples */
let http404Error = (404, "Not found")   //A tuple of type (Int, String)
/* Decomposing a tuple */
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")
/* Alternative method to access individual elements in a tuple */
//print("The status code is \(https404Error.0)")
//print("The status message is \(https404Error.1)")

/* If you name the elements in a tuple, you can access their values using the given names */
let https200Error = (statusCode: 200, message: "OK")
print("The status code is \(https200Error.statusCode)")
print("The status message is \(https200Error.message)")

/* Optionals */
var serverResponseCode: Int? = 404  //serverResponseCode contains an actual Int value
serverResponseCode = nil            //now it contains no value

var surveyAnswer: String?           //surverAnswer is automatically initialized with nil

let possibleNumber = "123"

/* Optional binding */
if let convertedNumber = Int(possibleNumber) {
    print("The string \(possibleNumber) has an integer value of \(convertedNumber)")
}
else {
    print("\(possibleNumber) cannot be converted to an interger value")
}

/* Fallback value */
let name: String? = nil
let greetingMessage = "Hello, " + (name ?? "friend") + "!"  //default value "friend" is used when the optional is nil
print(greetingMessage, terminator: "")

/* Force Unwrapping */
let convertedNumber = Int(possibleNumber)

let number = convertedNumber!       //this is the equivalent of fatalError()

guard let number = convertedNumber else {
    fatalError("This number was invalid")
}

/* Implictly unwrapped optional */
let assumedString: String! = "An implictly unwrapped optional string"
let implicitString: String = assumedString     //unwrapped automatically

/* Error handling */
enum SandwichError: Error {
    case outOfCleanDishes
    case missingIngredients(ingredients: [String])
}

func makeASandwich() throws {
    // Function which might throw an error
}

do {
    try makeASandwich()
} catch SandwichError.outOfCleanDishes {
    //washDishes()
} catch SandwichError.missingIngredients(let ingredients) {
    //buyIngredients(ingredients)
}
